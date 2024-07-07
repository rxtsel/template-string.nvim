local filetypes = require("template-string.allowed_filetypes")
local u = require("template-string.react_utils")
local M = {}

--- Replaces quotes in a line based on the presence of template literals and context.
-- @param line The line of text to process.
-- @param use_brackets A boolean indicating if brackets should be used.
-- @return The processed line with appropriate quote replacements.
local function replace_quotes(line, use_brackets)
	-- Replace quotes with backticks and brackets if ${} is found and use_brackets is true
	line = line:gsub("(['\"])(.-)(%${.-})(.-)%1", function(quote, before, inside, after)
		if use_brackets then
			return "{`" .. before .. inside .. after .. "`}"
		else
			return "`" .. before .. inside .. after .. "`"
		end
	end)

	-- Revert backticks and brackets to original quotes if ${} is not found in the content
	line = line:gsub("{`([^`]*)`}", function(content)
		if not content:find("%${.-}") then
			local original_quote = line:match("[\"']") or '"'
			return original_quote .. content .. original_quote
		end
		return "{`" .. content .. "`}"
	end)

	-- Revert solitary backticks to original quotes if ${} is not found in the content
	line = line:gsub("`([^`]*)`", function(content)
		if not content:find("%${.-}") then
			local original_quote = line:match("[\"']") or '"'
			return original_quote .. content .. original_quote
		end
		return "`" .. content .. "`"
	end)

	return line
end

--- Replaces quotes in the current line of the buffer if the filetype is allowed.
function M.replace_quotes_in_line()
	if not filetypes.is_allowed_filetype() then
		return
	end

	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
	local new_line = replace_quotes(line, u.is_inside_react_opening_element())

	-- Update the buffer if there were changes
	if new_line ~= line then
		vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
	end
end

return M
