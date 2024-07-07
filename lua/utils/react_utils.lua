local ts = require("nvim-treesitter.ts_utils")

local M = {}

-- Función para verificar si el cursor está dentro de una prop de React
function M.is_inside_react_opening_element()
	local node = ts.get_node_at_cursor()

	if not node then
		return false
	end

	-- Verificar si el nodo es un elemento de apertura JSX/TSX or prop
	if node:type() == "string" or node:type() == "template_string" then
		local prev_node = ts.get_previous_node(node)

		if not prev_node then
			return false
		end

		if prev_node:type() == "property_identifier" then
			return true
		end
	end

	return false
end

return M
