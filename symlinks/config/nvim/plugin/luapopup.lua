-- Luapopup - get a popup with lua buffer and run the code in neovim afterwards
-- Provides the same for fennel too
local popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local lua_utils = require("esensar.lua_utils")

local last_lua_win
local last_fennel_win

local popup_type = {
	lua = 1,
	fennel = 2,
}
local restore_commands = {
	[popup_type.lua] = ":LuaPopupRestore",
	[popup_type.fennel] = ":FennelPopupRestore",
}
local eval_functions = {
	[popup_type.lua] = lua_utils.eval_lua_buffer,
	[popup_type.fennel] = lua_utils.eval_fennel_buffer,
}
local validate_functions = {
	[popup_type.lua] = lua_utils.is_valid_lua_code_buffer,
	[popup_type.fennel] = function(_)
		-- No validation for fennel
		return true
	end,
}

local function get_last_win(type)
	if type == popup_type.lua then
		return last_lua_win
	elseif type == popup_type.fennel then
		return last_fennel_win
	end
	return nil
end

local function set_last_win(type, win)
	if type == popup_type.lua then
		last_lua_win = win
	elseif type == popup_type.fennel then
		last_fennel_win = win
	end
end

local function popup_and_run(type)
	local last_win = get_last_win(type)
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
		vim.notify("Cancelled operation, code not run! Use " .. restore_commands[type] .. " to restore buffer")
		win:hide()
	end

	local function run()
		local st, r = eval_functions[type](win.bufnr)
		if st == false then
			vim.notify("Execution failed: \n" .. r, vim.log.levels.ERROR)
		else
			vim.notify("Successfully executed operation!")
		end
	end

	-- mount/open the component
	win:mount()

	-- map keys
	win:map("n", "<CR>", function(_)
		local valid, message = validate_functions[type](win.bufnr)
		if not valid then
			vim.notify("Parsing code failed: \n" .. vim.inspect(message), vim.log.levels.ERROR)
		else
			hidden = true
			win:hide()
			run()
		end
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

	set_last_win(type, win)
end

local function restore_popup(type)
	get_last_win(type):show()
end

vim.api.nvim_create_user_command("LuaPopup", function()
	popup_and_run(popup_type.lua)
end, { desc = "Show a popup for writing lua code that will be executed after closing" })

vim.api.nvim_create_user_command("LuaPopupRestore", function()
	if get_last_win(popup_type.lua) then
		restore_popup(popup_type.lua)
	else
		vim.notify("No popup to restore! Use :LuaPopup first!", vim.log.levels.WARN)
	end
end, { desc = "Restore last popup displayed with LuaPopup command" })

vim.api.nvim_create_user_command("FennelPopup", function()
	popup_and_run(popup_type.fennel)
end, { desc = "Show a popup for writing fennel code that will be executed after closing" })

vim.api.nvim_create_user_command("FennelPopupRestore", function()
	if get_last_win(popup_type.fennel) then
		restore_popup(popup_type.fennel)
	else
		vim.notify("No popup to restore! Use :FennelPopup first!", vim.log.levels.WARN)
	end
end, { desc = "Restore last popup displayed with FennelPopup command" })
