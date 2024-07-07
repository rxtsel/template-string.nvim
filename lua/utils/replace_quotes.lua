local filetypes = require("utils.allowed_filetypes")
local u = require("utils.react_utils")
local M = {}

-- Reemplazar comillas por brackets y backticks cuando se encuentran "${}" en el valor de una prop. Ex. propName={'hello ${value}'}
local function replace_quotes_with_backticks_and_brackets(line)
	-- Reemplazar comillas por backticks y brackets
	line = line:gsub("(['\"])(.-)%${(.-)}(.-)%1", function(_, before, inside, after)
		return "{`" .. before .. "${" .. inside .. "}" .. after .. "`}"
	end)

	-- Also handle reverting solitary backticks on normal lines
	line = line:gsub("`([^`]*)`", function(content)
		if not content:find("%${") then
			local original_quote = line:match("[\"']") or '"'
			return original_quote .. content .. original_quote
		end
		return "`" .. content .. "`"
	end)

	return line
end

function M.replace_quotes_in_line()
	if not filetypes.is_allowed_filetype() then
		return
	end

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
	local new_line = line

	-- Check if inside a JSX/TSX element or opening element
	if u.is_inside_react_opening_element() then
		new_line = replace_quotes_with_backticks_and_brackets(new_line)
	else
		-- Replace quotes with backticks only when ${} is found
		new_line = new_line:gsub("(['\"])(.-)%${(.-)}(.-)%1", function(_, before, inside, after)
			return "`" .. before .. "${" .. inside .. "}" .. after .. "`"
		end)

		-- Also handle reverting solitary backticks on normal lines
		new_line = new_line:gsub("`([^`]*)`", function(content)
			if not content:find("%${") then
				local original_quote = line:match("[\"']") or '"'
				return original_quote .. content .. original_quote
			end
			return "`" .. content .. "`"
		end)
	end

	-- Update the buffer if there were changes
	if new_line ~= line then
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	end
end

return M
