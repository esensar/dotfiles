-------------------------------------------------------------------------------
--    - LSP related keymaps -
-------------------------------------------------------------------------------
default_opts = {noremap = true, silent = true}

-- Lsp keymaps
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
vim.api.nvim_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_opts)
vim.api.nvim_set_keymap('n', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
vim.api.nvim_set_keymap('n', '<Leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
vim.api.nvim_set_keymap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action_range()<CR>', default_opts)

completion_opts = {silent = true}

-- Completion keymaps
vim.api.nvim_set_keymap('i', '<C-n>', '<Plug>(completion_trigger)', completion_opts)
