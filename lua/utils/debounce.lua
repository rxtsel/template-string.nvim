local vim = vim

local M = {}

function M.debounce(fn, ms)
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

return M
