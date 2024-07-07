local M = {}

local debounce = require("template-string.debounce")
local quotes = require("template-string.replace_quotes")

--- Configures the behavior of the plugin.
function M.setup()
	-- Create a debounced version of the replace_quotes_in_line function
	local debounced_replace = debounce.debounce(quotes.replace_quotes_in_line, 100)

	-- Set up an autocmd to trigger the debounced function on TextChanged and TextChangedI events
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		callback = debounced_replace,
	})
end

--- @export
return M
