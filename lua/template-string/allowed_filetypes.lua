local vim = vim

local M = {}

-- List of allowed file types for syntax checking
local allowed_filetypes = {
	javascript = true,
	typescript = true,
	javascriptreact = true,
	typescriptreact = true,
}

--- Checks if the current buffer's file type is allowed for syntax checking.
-- @return boolean indicating if the file type is allowed.
function M.is_allowed_filetype()
	local filetype = vim.bo.filetype
	return allowed_filetypes[filetype] or false
end

return M
