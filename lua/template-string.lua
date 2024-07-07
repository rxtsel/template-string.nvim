local M = {}

local debounce = require("utils.debounce")
local quotes = require("utils.replace_quotes")

--- Configures the plugin behavior.
function M.setup()
	local debounced_replace = debounce.debounce(quotes.replace_quotes_in_line, 100)
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		callback = debounced_replace,
	})
end

return M
