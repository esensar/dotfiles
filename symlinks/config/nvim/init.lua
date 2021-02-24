if require('init.first_load')() then
  return
end

vim.api.nvim_exec('let $OVIMHOME = $HOME."/.vim"', false)
vim.api.nvim_exec('let $VIMHOME = $HOME."/.config/nvim"', false)
vim.api.nvim_exec('let $NVIMHOME = $HOME."/.local/share/nvim"', false)
vim.api.nvim_exec('let $VIMPLUGINS = expand($VIMHOME."/lua/personal/plugins.lua")', false)

-- Leader config to <Space>
vim.g.mapleader = ' '

-- Globals taken from TJ config
-- Helpful for configuration
-- Might be removed in future version of NeoVim
require('init.globals')

require('init.plugins')

require('init.options')

require('lsp')

-- Colorscheme
vim.cmd('syntax on')
require('init.colors')

vim.api.nvim_set_keymap('n', 'Q', 'gq', {})
vim.api.nvim_set_keymap('i', '<C-U>', '<C-G>u<C-U>', {noremap = true})

vim.cmd('command! Wq :wq')
vim.cmd('command! W :w')

vim.api.nvim_set_keymap('n', '<Leader>c', ':ccl <bar> lcl<CR>', {noremap = true})

-- Allow recursive searches
vim.cmd('set path+=**')

-- Save whenever switching windows or leaving vim. This is useful when running
-- the tests inside vim without having to save all files first.
vim.cmd('autocmd FocusLost,WinLeave * :silent! wa')

-- automatically rebalance windows on vim resize
vim.cmd('autocmd VimResized * :wincmd =')
