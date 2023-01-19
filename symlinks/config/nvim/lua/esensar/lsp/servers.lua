-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()
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
			vim.fn.glob("$HOME") .. "/.local/share/lsp/dotnet/omnisharp/run",
			"--languageserver",
			"--hostPID",
			tostring(vim.fn.getpid()),
		},
	},
	lemminx = {
		cmd = { "lemminx" },
	},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
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
local nlua_capabilities = vim.deepcopy(common_config.capabilities)
nlua_capabilities.textDocument.formatting = false
nlua_capabilities.textDocument.rangeFormatting = false
require("nlua.lsp.nvim").setup(
	lspconfig,
	vim.tbl_extend("force", common_config, {
		-- Tell LSP which globals should be considered real
		globals = {},
		capabilities = nlua_capabilities,
	})
)

-- Flutter tools
require("flutter-tools").setup({
	lsp = common_config,
})

-- Rust tools
local rt = require("rust-tools")

rt.setup({
	server = vim.tbl_extend("force", common_config, {
		on_attach = function(client, bufnr)
			common_config.on_attach(client, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	}),
})
