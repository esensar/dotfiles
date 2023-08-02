return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- Tpope general improvements
		use("tpope/vim-sensible") -- Sane defaults
		use("tpope/vim-endwise") -- Add closing statements automatically for if, function etc
		use("tpope/vim-surround") -- Surround with ', ", etc
		use("tpope/vim-fugitive") -- Git integration
		use("tpope/vim-vinegar") -- Netrw improvements
		use({ "tpope/vim-obsession", cmd = "Obsession" }) -- Session.vim management
		use({
			"kristijanhusak/vim-dadbod-ui",
			cmd = "DBUI",
			requires = "tpope/vim-dadbod", -- database access
		}) -- UI For Dadbod
		use("kristijanhusak/vim-dadbod-completion") -- Dadbod completion
		use("tpope/vim-speeddating") -- <C-A> and <C-X> for dates
		use("tpope/vim-dispatch") -- Dispatch command
		use("tpope/vim-projectionist") -- Project config file!
		use("tpope/vim-unimpaired") -- Additional [ and ] mappings
		use("tpope/vim-repeat") -- Better . repeat
		use("tpope/vim-commentary") -- Commenting motion
		use("tpope/vim-sleuth") -- Intendation heuristics
		use("tpope/vim-eunuch") -- UNIX helpers

		-- General improvements
		use("lewis6991/gitsigns.nvim") -- Git signs
		use({ "godlygeek/tabular", cmd = "Tabularize" }) -- Tabular command for alignment
		use("vim-scripts/utl.vim") -- Universal text linking
		use({ "mbbill/undotree", cmd = "UndotreeToggle" }) -- Undos in a tree for easy access
		use("mhinz/vim-grepper") -- Grepper command - improved grepping throughout project
		use("radenling/vim-dispatch-neovim") -- vim-dispatch for neovim - uses terminal
		use("wellle/targets.vim") -- Additional targets for inside and around motions
		use("flazz/vim-colorschemes") -- All popular colorschemes
		use("romainl/vim-qf") -- Quickfix list upgrades
		use({ "romainl/vim-devdocs", cmd = "DD" }) -- Quick DevDocs.io search using :DD
		use("gpanders/editorconfig.nvim") -- .editorconfig support
		use("lewis6991/impatient.nvim") -- Caching lua modules for faster startup
		use("rcarriga/nvim-notify") -- notifications UI
		use("MunifTanjim/nui.nvim") -- General UI
		use("jiangmiao/auto-pairs") -- Autoclosing of brackets and quotes

		-- Tools
		use("direnv/direnv.vim") -- Integration with Direnv
		use("nvim-neotest/neotest") -- Running tests from NeoVim
		use("nvim-neotest/neotest-plenary")
		use("rouge8/neotest-rust")
		use("nvim-neotest/neotest-vim-test") -- vim-test plugin for neotest
		use("vim-test/vim-test") -- Running tests from vim
		use("mfussenegger/nvim-dap") -- Debug Adapter Protocol
		use("rcarriga/nvim-dap-ui") -- UI components for DAP
		use("theHamsta/nvim-dap-virtual-text") -- Virtual text display for DAP
		use("diepm/vim-rest-console") -- REST console for vim
		use("https://codeberg.org/esensar/nvim-dev-container") -- devcontainer.json support
		use("jbyuki/one-small-step-for-vimkind") -- Debugger for Nvim-Lua
		use("https://codeberg.org/neovim-java/neovim-java-plugin-host") -- Host for Java plugins

		-- Snippets
		use("L3MON4D3/LuaSnip") -- snippets support
		use("rafamadriz/friendly-snippets") -- Collection of snippets
		use("saadparwaiz1/cmp_luasnip") -- cmp snippets support

		-- Language support
		use({ "tpope/vim-rails", ft = "ruby" }) -- Enables all rails command through vim and integrates with projectionist
		use({ "c-brenn/phoenix.vim", ft = "elixir" }) -- Similar to vim-rails, but for phoenix
		use("Olical/conjure") -- Lisp languages REPL integration
		use("Olical/aniseed") -- Fennel nvim support
		use("vimwiki/vimwiki") -- Vimwiki - personal wiki in vim
		use("https://codeberg.org/vimwiki-reviews/vimwiki-reviews-lua") -- Vimwiki extension for periodic reviews
		use({ "ledger/vim-ledger", ft = "ledger" }) -- Support for ledger-cli format
		use({ "tandrewnichols/vim-docile", ft = "help" }) -- Support for vim doc.txt format
		use({ "habamax/vim-godot", ft = "gdscript" }) -- Godot engine (and script) support
		use("guns/vim-sexp") -- Precision editing for S-expressions
		use("tpope/vim-sexp-mappings-for-regular-people") -- Simpler keymaps for vim-sexp
		use({ "tridactyl/vim-tridactyl", ft = "tridactyl" }) -- Tridactyl config file support
		use({ "aklt/plantuml-syntax", ft = "plantuml" }) -- PlantUML support
		use({ "cdelledonne/vim-cmake", ft = "cmake" }) -- CMake integration

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Treesitter integration
		use("nvim-treesitter/playground") -- TSPlaygroundToggle - access treesitter data

		-- LSP
		use("neovim/nvim-lspconfig") -- Easy LSP Config
		use("williamboman/mason.nvim") -- Easy tool install
		use("williamboman/mason-lspconfig.nvim") -- Lspconfig support for mason
		use("hrsh7th/cmp-nvim-lsp") -- LSP source for cmp
		use("hrsh7th/cmp-buffer") -- Buffer source for nvim-cmp
		use("hrsh7th/cmp-path") -- Path source for nvim-cmp
		use("hrsh7th/cmp-nvim-lua") -- Nvim-Lua source for nvim-cmp
		use("hrsh7th/cmp-omni") -- omnifunc source for nvim-cmp
		use("hrsh7th/nvim-cmp") -- completion integration
		use("jose-elias-alvarez/null-ls.nvim") -- Linting and formatting

		-- LSP language specific
		use("folke/neodev.nvim") -- Built-in Lua integration with LSP
		use("akinsho/flutter-tools.nvim") -- Additional flutter integrations
		use("simrat39/rust-tools.nvim") -- Additional rust integrations
		use({ "mfussenegger/nvim-jdtls", ft = "java" }) -- Additional java integrations

		-- Lua support
		use("nvim-lua/popup.nvim") -- Popup API integration - needed for some plugins
		use("nvim-lua/plenary.nvim") -- Lua helpers

		-- Telescope
		use("nvim-telescope/telescope.nvim") -- Fuzzy searcher
		use("nvim-telescope/telescope-dap.nvim") -- DAP integration for Telescope
		use("nvim-telescope/telescope-ui-select.nvim") -- UI select for Telescope
	end,
})
