local aeval = require("aniseed.eval")

local M = {}

function M.eval_lua_buffer(bufnr)
	local buffer_content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	return M.eval_lua_code(table.concat(buffer_content, "\n"))
end

function M.eval_lua_code(code_string)
	-- Taken from https://github.com/bfredl/nvim-luadev/blob/master/lua/luadev.lua
	local block = coroutine.create(loadstring(code_string))
	local res = { coroutine.resume(block) }
	if not res[1] then
		_G._errstack = block
		-- if the only frame on the traceback is the chunk itself, skip the traceback
		if debug.getinfo(block, 0, "f").func ~= code_string then
			res[2] = debug.traceback(block, res[2], 0)
		end
	end
	return unpack(res)
end

function M.eval_fennel_buffer(bufnr)
	local buffer_content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	return M.eval_fennel_code(table.concat(buffer_content, "\n"))
end

function M.eval_fennel_code(code_string)
	return aeval.str(code_string, {})
end

return M
