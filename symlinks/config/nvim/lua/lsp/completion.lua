-------------------------------------------------------------------------------
--    - LSP completion config -
-------------------------------------------------------------------------------
-- Use <Tab> and <S-Tab> to navigate through popup menu

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"
-- Avoid showing message extra message when using completion
vim.cmd('set shortmess+=c')
vim.cmd('let g:completion_enable_snippet = "UltiSnips"')
vim.cmd('let g:completion_confirm_key = "\\<C-y>"')
vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
