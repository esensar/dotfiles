if require("esensar.init.first_load")() then
	return
end

-- Allow `require('impatient')` to fail, in case plugins are not yet installed
local _ = pcall(require, "impatient")

vim.cmd([[filetype plugin indent on]])

vim.api.nvim_exec('let $OVIMHOME = $HOME."/.vim"', false)
vim.api.nvim_exec('let $VIMHOME = $HOME."/.config/nvim"', false)
vim.api.nvim_exec('let $NVIMHOME = $HOME."/.local/share/nvim"', false)
vim.api.nvim_exec('let $VIMPLUGINS = expand($VIMHOME."/lua/esensar/init/plugins.lua")', false)

-- Leader config to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("esensar.init.plugins")

require("esensar.init.options")

require("esensar.lsp")

-- Colorscheme
vim.cmd("syntax on")
require("esensar.init.colors")

vim.keymap.set("n", "Q", "gq", { noremap = false })
vim.keymap.set("i", "<C-U>", "<C-G>u<C-U>")

vim.cmd("command! Wq :wq")
vim.cmd("command! W :w")

vim.keymap.set("n", "<Leader>c", ":ccl <bar> lcl<CR>")

-- Allow recursive searches
vim.cmd("set path+=**")

-- automatically rebalance windows on vim resize
vim.cmd("autocmd VimResized * :wincmd =")

vim.api.nvim_create_user_command("EditConfigInitLua", function()
	vim.cmd("edit $VIMHOME/init.lua")
end, {})

vim.api.nvim_create_user_command("EditConfigPlugins", function()
	vim.cmd("edit $VIMPLUGINS")
end, {})
