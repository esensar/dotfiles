-------------------------------------------------------------------------------
--    - LSP servers configuration -
-------------------------------------------------------------------------------

require("neodev").setup({
	library = { plugins = { "neotest", "plenary.nvim" }, types = true },
	-- Always add neovim plugins into lua_ls library, even if not neovim config
	override = function(_, library)
		library.enabled = true
		library.plugins = true
	end,
})

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
	"dotls",
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
	"vale_ls",
	"vimls",
	"wgsl_analyzer",
	"zls",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(vim.tbl_extend("force", common_config, configuration_overrides[lsp] or {}))
end

-- Flutter tools
require("flutter-tools").setup({
	lsp = common_config,
	flutter_lookup_cmd = "asdf where flutter",
})

-- Rust tools
vim.g.rustaceanvim = {
	server = vim.tbl_extend("force", common_config, {
		on_attach = function(client, bufnr)
			common_config.on_attach(client, bufnr)
		end,
		cmd = { "ra-multiplex" },
		-- init_options = {
		-- 	lspMux = {
		-- 		version = "1",
		-- 		method = "connect",
		-- 		server = "rust-analyzer",
		-- 	},
		-- },
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
				procMacro = {
					enable = true,
				},
				hoverActions = {
					enable = false,
				},
				cargo = {
					loadOutDirsFromCheck = true,
					features = "all",
				},
			},
		},
	}),
}
