-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	require'completion'.on_attach()
end
-- Lsp language servers
lspconfig.bashls.setup {on_attach = on_attach}
lspconfig.clangd.setup {on_attach = on_attach}
lspconfig.dartls.setup {on_attach = on_attach}
lspconfig.jsonls.setup {on_attach = on_attach}
lspconfig.pyright.setup {on_attach = on_attach}
lspconfig.rust_analyzer.setup {on_attach = on_attach}
lspconfig.vimls.setup {on_attach = on_attach}

-- Lua bultin lsp
-- require('nlua.lsp.nvim').setup(lspconfig, {
--   on_attach = on_attach,

--   -- Include globals you want to tell the LSP are real :)
--   globals = {
--   }
-- })
