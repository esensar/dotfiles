-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local common_config = require("lsp.server_config")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lsp default language servers
local servers = { "bashls", "clangd", "cucumber_language_server", "crystalline", "dockerls", "jsonls", "hls", "pyright", "rust_analyzer", "kotlin_language_server", "mint", "vimls", "clojure_lsp", "gopls", "gdscript", "solang", "terraformls", "tsserver" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup { 
		on_attach = common_config.on_attach,
		capabilities = capabilities
	}
end

-- Lua bultin lsp
require('nlua.lsp.nvim').setup(lspconfig, {
  on_attach = common_config.on_attach,
	capabilities = capabilities,

  -- Include globals you want to tell the LSP are real :)
  globals = {}
})

-- Flutter tools
require('flutter-tools').setup {
	lsp = {
		on_attach = common_config.on_attach,
		capabilities = capabilities
	}
}

-- Dotnet LS
local pid = vim.fn.getpid()
local omnisharp_bin = vim.fn.glob('$HOME') .. "/lsp/dotnet/omnisharp/run"
lspconfig.omnisharp.setup {
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
	on_attach = common_config.on_attach;
	capabilities = capabilities
}

-- Leminx (XML Language server)
lspconfig.lemminx.setup {
	cmd = { "lemminx" };
	on_attach = common_config.on_attach;
	capabilities = capabilities
}
