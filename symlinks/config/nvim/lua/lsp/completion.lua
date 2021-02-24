-------------------------------------------------------------------------------
--    - LSP completion config -
-------------------------------------------------------------------------------
-- Use <Tab> and <S-Tab> to navigate through popup menu

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"
-- Avoid showing message extra message when using completion
vim.cmd('set shortmess+=c')
vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_confirm_key = '<C-y>'
vim.g.completion_enable_snippet = 'UltiSnips'
