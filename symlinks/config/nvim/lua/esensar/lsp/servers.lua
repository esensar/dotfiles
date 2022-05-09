-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
local common_config = require("esensar.lsp.server_config")

-- Language specific LSP config overrides
local configuration_overrides = {
	gdscript = {
		flags = {
			-- Slow Godot LS
			debounce_text_changes = 600,
		},
	},
	omnisharp = {
		cmd = {
			vim.fn.glob("$HOME") .. "/lsp/dotnet/omnisharp/run",
			"--languageserver",
			"--hostPID",
			tostring(vim.fn.getpid()),
		},
	},
	lemminx = {
		cmd = { "lemminx" },
	},
}

-- Lsp default language servers
local servers = {
	"bashls",
	"clangd",
	"clojure_lsp",
	"cmake",
	"crystalline",
	"cucumber_language_server",
	"dockerls",
	"gdscript",
	"gopls",
	"hls",
	"jsonls",
	"kotlin_language_server",
	"lemminx",
	"mint",
	"omnisharp",
	"pyright",
	"rust_analyzer",
	"solang",
	"terraformls",
	"tsserver",
	"vimls",
	"zls",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(vim.tbl_extend("force", common_config, configuration_overrides[lsp] or {}))
end

-- Lua bultin lsp
require("nlua.lsp.nvim").setup(
	lspconfig,
	vim.tbl_extend("force", common_config, {
		-- Tell LSP which globals should be considered real
		globals = {},
	})
)

-- Flutter tools
require("flutter-tools").setup({
	lsp = common_config,
})
