local vim = vim

local M = {}

local allowed_filetypes = {
	javascript = true,
	typescript = true,
	javascriptreact = true,
	typescriptreact = true,
}

function M.is_allowed_filetype()
	local filetype = vim.bo.filetype
	return allowed_filetypes[filetype] or false
end

return M
