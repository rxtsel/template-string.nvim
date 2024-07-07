local vim = vim

local M = {}

--- Creates a debounced version of a function.
-- @param fn The function to debounce.
-- @param ms The debounce time in milliseconds.
-- @return The debounced function.
function M.debounce(fn, ms)
	local timer = vim.loop.new_timer() -- Create a new timer from Vim's event loop

	return function(...)
		timer:stop() -- Stop the timer to reset debounce time
		local argv = { ... } -- Capture arguments passed to the debounced function

		timer:start(
			ms,
			0,
			vim.schedule_wrap(function()
				fn(unpack(argv)) -- Call the original function after debounce time
			end)
		)
	end
end

return M
