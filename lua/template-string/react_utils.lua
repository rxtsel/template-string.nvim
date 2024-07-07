local ts = require("nvim-treesitter.ts_utils")

local M = {}

--- Checks if the cursor is inside a React prop or JSX/TSX opening element.
-- @return boolean indicating if the cursor is inside a React prop or JSX/TSX opening element.
function M.is_inside_react_opening_element()
	local node = ts.get_node_at_cursor()

	if not node then
		return false
	end

	-- Check if the node is a JSX/TSX string or template string
	if node:type() == "string" or node:type() == "template_string" then
		local prev_node = ts.get_previous_node(node)

		if not prev_node then
			return false
		end

		-- Check if the previous node is a property identifier
		if prev_node:type() == "property_identifier" then
			return true
		end
	end

	return false
end

return M
