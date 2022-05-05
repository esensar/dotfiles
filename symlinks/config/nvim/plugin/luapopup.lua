-- Luapopup - get a popup with lua buffer and run the code in neovim afterwards
local popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local lua_utils = require("esensar.lua_utils")

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
		local st, r = lua_utils.eval_lua_buffer(win.bufnr)
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
