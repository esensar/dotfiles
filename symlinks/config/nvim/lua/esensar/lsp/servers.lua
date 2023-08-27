-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()
require("neodev").setup({
	library = { plugins = { "neotest", "plenary.nvim" }, types = true },
})
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
	lua_ls = {
		settings = {
			Lua = {
				format = {
					enable = false,
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
	"html",
	"jedi_language_server",
	"jsonls",
	"kotlin_language_server",
	"lemminx",
	"lua_ls",
	"mint",
	"omnisharp",
	"solang",
	"terraformls",
	"tsserver",
	"vimls",
	"zls",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(vim.tbl_extend("force", common_config, configuration_overrides[lsp] or {}))
end

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
