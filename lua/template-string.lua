---@class TemplateStringConfig
---@field jsx_brackets boolean | nil

local M = {}

local allowed_filetypes = {
	javascript = true,
	typescript = true,
	javascriptreact = true,
	typescriptreact = true,
}

local function is_allowed_filetype()
	local filetype = vim.bo.filetype
	return allowed_filetypes[filetype] or false
end

-- Function to wrap with {``} if inside a JSX/TSX component
local function wrap_with_brackets_if_necessary(content)
	if content:find("%${") then
		return "={`" .. content .. "`}"
	else
		return '="' .. content .. '"'
	end
end

-- Function to replace quotes in the current line
local function replace_quotes_in_line()
	if not is_allowed_filetype() then
		return
	end

	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

	if not line then
		return
	end

	local new_line = line

	-- Replace quotes with backticks when ${ is found
	new_line = new_line:gsub("(['\"])(.-)%${(.-)}(.-)%1", function(quote, before, inside, after)
		return "`" .. before .. "${" .. inside .. "}" .. after .. "`"
	end)

	if M.jsx_brackets then
		-- Wrap with {``} if inside a JSX/TSX component
		new_line = new_line:gsub("=%s*`([^`]*)`", wrap_with_brackets_if_necessary)

		-- Revert backticks to original quotes if ${ is not found
		new_line = new_line:gsub("={[`{]+([^`]*)[`}]+}", function(content)
			if not content:find("%${") then
				-- Determine the original type of quotes, double or single
				local original_quote = line:match("=[\"']") and '"' or line:match("=['\"]") and "'" or '"'
				return "=" .. original_quote .. content .. original_quote
			end
			return "={" .. "`" .. content .. "`" .. "}"
		end)
	end

	-- Also handle reverting solitary backticks on normal lines
	new_line = new_line:gsub("`([^`]*)`", function(content)
		if not content:find("%${") then
			-- Determine the original type of quotes, double or single
			local original_quote = line:match("[\"']") or '"'
			return original_quote .. content .. original_quote
		end
		return "`" .. content .. "`"
	end)

	if new_line ~= line then
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	end
end

-- Function to execute update with debounce
local function debounce(fn, ms)
	local timer = vim.loop.new_timer()
	return function(...)
		timer:stop()
		local argv = { ... }
		timer:start(
			ms,
			0,
			vim.schedule_wrap(function()
				fn(unpack(argv))
			end)
		)
	end
end

--- Configures the plugin behavior.
---@param opts TemplateStringConfig | nil Optional plugin configuration.
function M.setup(opts)
	opts = opts or {}
	-- Enable brackets for JSX/TSX
	local jsx_brackets = opts.jsx_brackets == nil or opts.jsx_brackets
	M.jsx_brackets = jsx_brackets

	-- Enable debounce
	local debounced_replace = debounce(replace_quotes_in_line, 100)
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		callback = debounced_replace,
	})
end

return M
