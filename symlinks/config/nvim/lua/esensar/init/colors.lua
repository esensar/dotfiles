vim.o.termguicolors = true
vim.o.background = "dark"

require("gruvbox").setup({
	---@diagnostic disable-next-line: missing-fields
	italic = {
		strings = false,
	},
})

vim.cmd.colorscheme("gruvbox")
