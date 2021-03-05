-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	require'completion'.on_attach()

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	default_opts = {noremap = true, silent = true}

	-- Lsp keymaps
	buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
	buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_opts)
	buf_set_keymap('n', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
	buf_set_keymap('n', '<Leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
	buf_set_keymap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action_range()<CR>', default_opts)

	completion_opts = {silent = true}

	-- Completion keymaps
	buf_set_keymap('i', '<C-n>', '<Plug>(completion_trigger)', completion_opts)
end

-- Lsp default language servers
local servers = { "bashls", "clangd", "dartls", "jsonls", "pyright", "rust_analyzer", "kotlin_language_server", "vimls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach }
end

-- Lua bultin lsp
require('nlua.lsp.nvim').setup(lspconfig, {
  on_attach = on_attach,

  -- Include globals you want to tell the LSP are real :)
  globals = {
  }
})
