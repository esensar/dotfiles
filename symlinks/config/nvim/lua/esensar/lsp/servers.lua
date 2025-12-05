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

require("mason").setup()
require("mason-lspconfig").setup()
local common_config = require("esensar.lsp.server_config")

-- Language specific LSP config overrides
local zig_loc = vim.api.nvim_exec2("!mise where zig", { output = true }).output
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
	vale_ls = {
		filetypes = vim.list_extend(
			vim.list_slice(require("lspconfig.configs.vale_ls").default_config.filetypes),
			{ "mail" }
		),
	},
	zls = {
		settings = {
			zig_exe_path = zig_loc .. "/zig",
			zig_lib_path = zig_loc .. "/lib",
		},
	},
}
-- Enables outside rust diagnostics config
vim.g.rust_diagnostics = "rust-analyzer"

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
	"mesonlsp",
	"mint",
	"omnisharp",
	"solang",
	"terraformls",
	"ts_ls",
	"vale_ls",
	"vimls",
	"wgsl_analyzer",
	"zls",
}
if vim.g.rust_diagnostics == "bacon-ls" then
	table.insert(servers, "bacon_ls")
else
	vim.lsp.enable("bacon_ls", false)
end
for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, vim.tbl_extend("force", common_config, configuration_overrides[lsp] or {}))
	vim.lsp.enable(lsp)
end

vim.lsp.config(
	"ctags_lsp",
	vim.tbl_extend("force", common_config, {
		cmd = { "ctags-lsp" },
		filetypes = { "hare" },
		root_dir = vim.uv.cwd(),
	})
)
vim.lsp.enable("ctags_lsp")

-- Flutter tools
require("flutter-tools").setup({
	lsp = common_config,
	flutter_lookup_cmd = "mise where flutter",
})

-- Rust tools
vim.g.rustaceanvim = vim.tbl_deep_extend("force", vim.g.rustaceanvim or {}, {
	dap = {
		configuration = false,
	},
	server = vim.tbl_extend("force", common_config, {
		on_attach = function(client, bufnr)
			common_config.on_attach(client, bufnr)
		end,
		logfile = vim.fn.tempname() .. "-rust-analyzer.log",
		cmd = function()
			return { "ra-multiplex", "client", "--", "--log-file", vim.g.rustaceanvim.server.logfile }
		end,
		default_settings = {
			["rust-analyzer"] = {
				check = {
					command = "clippy",
				},
				checkOnSave = vim.g.rust_diagnostics == "rust-analyzer",
				diagnostics = {
					enable = vim.g.rust_diagnostics == "rust-analyzer",
				},
				procMacro = {
					enable = true,
				},
				hoverActions = {
					enable = false,
				},
				cargo = {
					features = "all",
				},
			},
		},
	}),
})

require("crates").setup({
	lsp = {
		enabled = true,
		on_attach = function(client, bufnr)
			common_config.on_attach(client, bufnr)
		end,
		actions = true,
		completion = true,
		hover = true,
	},
})
