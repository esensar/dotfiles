return require("lazy").setup({
	-- Tpope general improvements
	"tpope/vim-sensible", -- Sane defaults,
	"tpope/vim-endwise", -- Add closing statements automatically for if, function etc
	"tpope/vim-surround", -- Surround with ', ", etc
	"tpope/vim-fugitive", -- Git integration
	"tpope/vim-vinegar", -- Netrw improvements
	{ "tpope/vim-obsession", cmd = "Obsession" }, -- Session.vim management
	"tpope/vim-dadbod", -- database access
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = "DBUI",
		dependencies = "tpope/vim-dadbod", -- database access
	}, -- UI For Dadbod
	"kristijanhusak/vim-dadbod-completion", -- Dadbod completion
	"tpope/vim-speeddating", -- <C-A> and <C-X> for dates
	"tpope/vim-dispatch", -- Dispatch command
	"tpope/vim-projectionist", -- Project config file!
	"tpope/vim-unimpaired", -- Additional [ and ] mappings
	"tpope/vim-repeat", -- Better . repeat
	"tpope/vim-sleuth", -- Intendation heuristics
	"tpope/vim-eunuch", -- UNIX helpers

	-- General improvements
	"lewis6991/gitsigns.nvim", -- Git signs
	{ "godlygeek/tabular", cmd = "Tabularize" }, -- Tabular command for alignment
	"vim-scripts/utl.vim", -- Universal text linking
	{ "mbbill/undotree", cmd = "UndotreeToggle" }, -- Undos in a tree for easy access
	"mhinz/vim-grepper", -- Grepper command - improved grepping throughout project
	"radenling/vim-dispatch-neovim", -- vim-dispatch for neovim - uses terminal
	"wellle/targets.vim", -- Additional targets for inside and around motions
	"ellisonleao/gruvbox.nvim", -- colorscheme
	"romainl/vim-qf", -- Quickfix list upgrades
	{ "romainl/vim-devdocs", cmd = "DD" }, -- Quick DevDocs.io search using :DD
	"gpanders/editorconfig.nvim", -- .editorconfig support
	"lewis6991/impatient.nvim", -- Caching lua modules for faster startup
	"j-hui/fidget.nvim", -- notifications UI
	"MunifTanjim/nui.nvim", -- General UI
	{
		"windwp/nvim-autopairs", -- Autoclosing of brackets and quotes
		event = "InsertEnter",
		config = true,
	},
	"nvim-pack/nvim-spectre", -- Find and replace

	-- Tools
	"direnv/direnv.vim", -- Integration with Direnv
	{
		"nvim-neotest/neotest", -- Running tests from NeoVim
		dependencies = {
			"lawrence-laz/neotest-zig",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-vim-test",
		},
		keys = {
			{ "<Leader>tn", mode = "n" },
			{ "<Leader>tdn", mode = "n" },
			{ "<Leader>tf", mode = "n" },
			{ "<Leader>tdf", mode = "n" },
			{ "<Leader>tl", mode = "n" },
			{ "<Leader>ts", mode = "n" },
			{ "<Leader>tds", mode = "n" },
			{ "<Leader>tp", mode = "n" },
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("rustaceanvim.neotest")({
						args = { "--no-capture" },
					}),
					require("neotest-zig")({
						dap = {
							adapter = "lldb",
						},
					}),
					require("neotest-plenary"),
					require("neotest-vim-test")({
						ignore_file_types = { "rust", "lua", "zig" },
					}),
				},
			})

			-- Map test running commands
			local opts = { silent = true }
			vim.keymap.set("n", "<Leader>tn", function()
				neotest.run.run()
			end, opts)
			vim.keymap.set("n", "<Leader>tdn", function()
				neotest.run.run({ strategy = "dap", suite = false })
			end, opts)
			vim.keymap.set("n", "<Leader>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, opts)
			vim.keymap.set("n", "<Leader>tdf", function()
				neotest.run.run({ vim.fn.expand("%"), strategy = "dap", suite = false })
			end, opts)
			vim.keymap.set("n", "<Leader>ts", function()
				neotest.run.run({ suite = true })
			end, opts)
			vim.keymap.set("n", "<Leader>tds", function()
				neotest.run.run({ strategy = "dap", suite = true })
			end, opts)
			vim.keymap.set("n", "<Leader>tl", function()
				neotest.run.run_last()
			end, opts)
			vim.keymap.set("n", "<Leader>tp", neotest.output_panel.open, opts)
			vim.keymap.set("n", "<Leader>ton", function()
				neotest.output.open({ enter = true })
			end, opts)
			vim.keymap.set("n", "<Leader>tof", function()
				neotest.output.open({ enter = true, position_id = vim.fn.expand("%") })
			end, opts)
			vim.keymap.set("n", "<Leader>tol", function()
				neotest.output.open({ enter = true, last_run = true })
			end, opts)
			vim.keymap.set("n", "<Leader>tos", neotest.output_panel.open, opts)
		end,
	},
	"nvim-neotest/nvim-nio",
	"nvim-neotest/neotest-plenary",
	"saecki/crates.nvim",
	"nvim-neotest/neotest-vim-test", -- vim-test plugin for neotest
	"vim-test/vim-test", -- Running tests from vim
	"mfussenegger/nvim-dap", -- Debug Adapter Protocol
	"rcarriga/nvim-dap-ui", -- UI components for DAP
	"theHamsta/nvim-dap-virtual-text", -- Virtual text display for DAP
	"diepm/vim-rest-console", -- REST console for vim
	"https://codeberg.org/esensar/nvim-dev-container", -- devcontainer.json support
	"jbyuki/one-small-step-for-vimkind", -- Debugger for Nvim-Lua
	"https://codeberg.org/neovim-java/neovim-java-plugin-host", -- Host for Java plugins

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
	}, -- snippets support
	"rafamadriz/friendly-snippets", -- Collection of snippets
	"saadparwaiz1/cmp_luasnip", -- cmp snippets support

	-- Language support
	{ "tpope/vim-rails", ft = "ruby" }, -- Enables all rails command through vim and integrates with projectionist
	{ "c-brenn/phoenix.vim", ft = "elixir" }, -- Similar to vim-rails, but for phoenix
	{ "clojure-vim/vim-jack-in", ft = "clojure" }, -- Clojure commands
	{
		"Olical/conjure",
		init = function()
			vim.g["conjure#filetypes"] = {
				"clojure",
				"fennel",
				"racket",
				"scheme",
				"lisp",
			}
		end,
	}, -- Lisp languages REPL integration
	"Olical/aniseed", -- Fennel nvim support
	{
		"vimwiki/vimwiki",
		init = function()
			local personal_wiki = {
				path = "~/doc/vimwiki/",
				ext = ".md",
				index = "Home",
				syntax = "markdown",
				auto_diary_index = 1,
				auto_generate_links = 1,
				auto_toc = 1,
			}
			local test_wiki = {
				path = "/tmp/",
			}
			vim.g.vimwiki_list = { personal_wiki, test_wiki }
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_listsyms = "✗○◐●✓"

			vim.api.nvim_create_user_command("VimwikiOpenSubdirectoryIndex", function(opts)
				require("esensar.vimwiki_extensions").open_subdirectory_index_file(opts.count, opts.args)
			end, {
				count = 0,
				nargs = 1,
			})
		end,
	}, -- Vimwiki - personal wiki in vim
	"https://codeberg.org/vimwiki-reviews/vimwiki-reviews-lua", -- Vimwiki extension for periodic reviews
	{ "ledger/vim-ledger", ft = "ledger" }, -- Support for ledger-cli format
	{ "tandrewnichols/vim-docile", ft = "help" }, -- Support for vim doc.txt format
	{ "habamax/vim-godot", ft = "gdscript" }, -- Godot engine (and script) support
	"guns/vim-sexp", -- Precision editing for S-expressions
	"tpope/vim-sexp-mappings-for-regular-people", -- Simpler keymaps for vim-sexp
	{ "tridactyl/vim-tridactyl", ft = "tridactyl" }, -- Tridactyl config file support
	{ "aklt/plantuml-syntax", ft = "plantuml" }, -- PlantUML support
	{ "cdelledonne/vim-cmake", ft = "cmake" }, -- CMake integration
	{ "https://git.sr.ht/~esensar/timelog-vim" }, -- Support for timelog format

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Treesitter integration
	"nvim-treesitter/playground", -- TSPlaygroundToggle - access treesitter data

	-- LSP
	"neovim/nvim-lspconfig", -- Easy LSP Config
	"williamboman/mason.nvim", -- Easy tool install
	"williamboman/mason-lspconfig.nvim", -- Lspconfig support for mason
	"hrsh7th/cmp-nvim-lsp", -- LSP source for cmp
	"hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
	"hrsh7th/cmp-path", -- Path source for nvim-cmp
	"hrsh7th/cmp-nvim-lua", -- Nvim-Lua source for nvim-cmp
	"hrsh7th/cmp-omni", -- omnifunc source for nvim-cmp
	"hrsh7th/nvim-cmp", -- completion integration
	"rcarriga/cmp-dap", -- DAP nvim-cmp
	"stevearc/conform.nvim", -- formatting support
	"mfussenegger/nvim-lint", -- linting support
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"jmbuhr/otter.nvim", -- LSP in embedded code blocks
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = { "toml" },
				group = vim.api.nvim_create_augroup("EmbedToml", {}),
				callback = function()
					require("otter").activate()
				end,
			})
		end,
	},

	-- LSP language specific
	"folke/neodev.nvim", -- Built-in Lua integration with LSP
	"akinsho/flutter-tools.nvim", -- Additional flutter integrations
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{ "mfussenegger/nvim-jdtls", ft = "java" }, -- Additional java integrations
	"scalameta/nvim-metals", -- Scala

	-- Lua support
	"nvim-lua/popup.nvim", -- Popup API integration - needed for some plugins
	"nvim-lua/plenary.nvim", -- Lua helpers

	-- Telescope
	"nvim-telescope/telescope.nvim", -- Fuzzy searcher
	"nvim-telescope/telescope-dap.nvim", -- DAP integration for Telescope
	"nvim-telescope/telescope-ui-select.nvim", -- UI select for Telescope
})
