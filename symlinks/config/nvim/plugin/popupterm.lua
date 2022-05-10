-- Popupterm - get a popup with terminal buffer
local popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local last_term_win

local function popup_terminal()
	if last_term_win then
		last_term_win:show()
		return
	end

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
	})

	-- mount/open the component
	win:mount()

	vim.cmd("edit term://" .. vim.env.SHELL)

	-- map keys
	win:map("n", "<Esc>", function(_)
		win:hide()
	end, { noremap = true })

	-- unmount component when cursor leaves buffer
	win:on(event.BufLeave, function()
		win:hide()
	end)

	win:on(event.BufDelete, function()
		last_term_win = nil
	end)

	last_term_win = win
end

vim.api.nvim_create_user_command("PopupTerm", function()
	popup_terminal()
end, {})
