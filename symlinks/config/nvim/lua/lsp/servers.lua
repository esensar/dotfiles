-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local common_config = require("lsp.server_config")

-- Lsp default language servers
local servers = { "bashls", "clangd", "cucumber_language_server", "crystalline", "dockerls", "jsonls", "pyright", "rust_analyzer", "kotlin_language_server", "mint", "vimls", "clojure_lsp", "gopls", "gdscript", "terraformls", "tsserver" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = common_config.on_attach }
end

-- Lua bultin lsp
require('nlua.lsp.nvim').setup(lspconfig, {
  on_attach = common_config.on_attach,

  -- Include globals you want to tell the LSP are real :)
  globals = {}
})

-- Flutter tools
require('flutter-tools').setup {
	lsp = {
		on_attach = common_config.on_attach
	}
}

-- Dotnet LS
local pid = vim.fn.getpid()
local omnisharp_bin = vim.fn.glob('$HOME') .. "/lsp/dotnet/omnisharp/run"
lspconfig.omnisharp.setup {
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
	on_attach = common_config.on_attach;
}

-- Leminx (XML Language server)
lspconfig.lemminx.setup {
	cmd = { "lemminx" };
	on_attach = common_config.on_attach;
}
