-- Common UI components

local nui_split = require("nui.split")
local nui_popup = require("nui.popup")

local M = {}

function M.new_bottom_split(opts)
	local split = nui_split(vim.tbl_extend("force", {
		relative = "editor",
		position = "bottom",
		size = "20%",
	}, opts))

	split:mount()

	return split
end

function M.new_centered_popup(opts)
	local split = nui_popup(vim.tbl_extend('force', {
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
	}, opts))

	split:mount()

	return split
end

return M
