-- Godot config

vim.wo.foldmethod = "expr"
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

vim.keymap.set("n", "<F4>", ":GodotRunLast<CR>", {
	buffer = true,
})
vim.keymap.set("n", "<F5>", ":GodotRun<CR>", {
	buffer = true,
})
vim.keymap.set("n", "<F6>", ":GodotRunCurrent<CR>", {
	buffer = true,
})
