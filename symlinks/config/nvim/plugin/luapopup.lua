-- Luapopup - get a popup with lua buffer and run the code in neovim afterwards
local popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local last_win

local function popup_and_run()
	if last_win then
		last_win:unmount()
	end

	local hidden = false
	local win = popup({
		enter = true,
		focusable = true,
		border = {
			style = "rounded",
		},
		position = "50%",
		size = {
			width = "80%",
			height = "60%",
		},
		buf_options = {
			modifiable = true,
			readonly = false,
			filetype = "lua",
		},
	})
	local function cancel()
		vim.notify("Cancelled operation, code not run! Use :LuaPopupRestore to restore buffer")
		win:hide()
	end

	local function run()
		local buffer_content = vim.api.nvim_buf_get_lines(win.bufnr, 0, -1, false)
		-- Taken from https://github.com/bfredl/nvim-luadev/blob/master/lua/luadev.lua
		local block = coroutine.create(loadstring(table.concat(buffer_content, "\n")))
		local res = { coroutine.resume(block) }
		if not res[1] then
			_G._errstack = block
			-- if the only frame on the traceback is the chunk itself, skip the traceback
			if debug.getinfo(block, 0, "f").func ~= buffer_content then
				res[2] = debug.traceback(block, res[2], 0)
			end
		end
		local st, r = unpack(res)
		if st == false then
			vim.notify("Execution failed: \n" .. r)
		else
			vim.notify("Successfully executed operation!")
		end
	end

	-- mount/open the component
	win:mount()

	-- map keys
	win:map("n", "<CR>", function(_)
		hidden = true
		win:hide()
		run()
	end, { noremap = true })
	win:map("n", "<Esc>", function(_)
		cancel()
	end, { noremap = true })

	-- unmount component when cursor leaves buffer
	win:on(event.BufLeave, function()
		-- Do not cancel if already hidden
		if not hidden then
			cancel()
		end
	end)

	last_win = win
end

local function restore_popup()
	last_win:show()
end

vim.api.nvim_create_user_command("LuaPopup", function()
	popup_and_run()
end, {})

vim.api.nvim_create_user_command("LuaPopupRestore", function()
	if last_win then
		restore_popup()
	else
		vim.notify("No popup to restore! Use :LuaPopup first!", vim.log.levels.WARN)
	end
end, {})
