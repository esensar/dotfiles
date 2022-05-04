return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- Tpope general improvements
		use("tpope/vim-sensible") -- Sane defaults
		use("tpope/vim-endwise") -- Add closing statements automatically for if, function etc
		use("tpope/vim-surround") -- Surround with ', ", etc
		use("tpope/vim-fugitive") -- Git integration
		use("tpope/vim-vinegar") -- Netrw improvements
		use("tpope/vim-obsession") -- Session.vim management
		use("tpope/vim-dadbod") -- Database access
		use("kristijanhusak/vim-dadbod-ui") -- UI For Dadbod
		use("tpope/vim-speeddating") -- <C-A> and <C-X> for dates
		use("tpope/vim-dispatch") -- Dispatch command
		use("tpope/vim-projectionist") -- Project config file!
		use("tpope/vim-unimpaired") -- Additional [ and ] mappings
		use("tpope/vim-repeat") -- Better . repeat
		use("tpope/vim-commentary") -- Commenting motion
		use("tpope/vim-sleuth") -- Intendation heuristics

		-- General improvements
		use("lewis6991/gitsigns.nvim") -- Git signs
		use("godlygeek/tabular") -- Tabular command for alignment
		use("vim-scripts/utl.vim") -- Universal text linking
		use({ "mbbill/undotree", cmd = "UndotreeToggle" }) -- Undos in a tree for easy access
		use("mhinz/vim-grepper") -- Grepper command - improved grepping throughout project
		use("radenling/vim-dispatch-neovim") -- vim-dispatch for neovim - uses terminal
		use("wellle/targets.vim") -- Additional targets for inside and around motions
		use("flazz/vim-colorschemes") -- All popular colorschemes
		use("romainl/vim-qf") -- Quickfix list upgrades
		use("romainl/vim-devdocs") -- Quick DevDocs.io search using :DD
		use("gpanders/editorconfig.nvim") -- .editorconfig support
		use("lewis6991/impatient.nvim") -- Caching lua modules for faster startup

		-- Tools
		use("direnv/direnv.vim") -- Integration with Direnv
		use("vim-test/vim-test") -- Running tests from vim
		use("mfussenegger/nvim-dap") -- Debug Adapter Protocol
		use("rcarriga/nvim-dap-ui") -- UI components for DAP
		use("theHamsta/nvim-dap-virtual-text") -- Virtual text display for DAP
		use("diepm/vim-rest-console") -- REST console for vim
		use("jamestthompson3/nvim-remote-containers") -- devcontainer.json support
		use("jbyuki/one-small-step-for-vimkind") -- Debugger for Nvim-Lua

		-- Snippets
		use("L3MON4D3/LuaSnip") -- snippets support
		use("rafamadriz/friendly-snippets") -- Collection of snippets
		use("saadparwaiz1/cmp_luasnip") -- cmp snippets support

		-- Language support
		use("tpope/vim-rails") -- Enables all rails command through vim and integrates with projectionist
		use("c-brenn/phoenix.vim") -- Similar to vim-rails, but for phoenix
		use("Olical/conjure") -- Lisp languages REPL integration
		use("Olical/aniseed") -- Fennel nvim support
		use("vimwiki/vimwiki") -- Vimwiki - personal wiki in vim
		use("esensar/vimwiki-reviews-lua") -- Vimwiki extension for periodic reviews
		use("ledger/vim-ledger") -- Support for ledger-cli format
		use("tandrewnichols/vim-docile") -- Support for vim doc.txt format
		use("habamax/vim-godot") -- Godot engine (and script) support
		use("guns/vim-sexp") -- Precision editing for S-expressions
		use("tpope/vim-sexp-mappings-for-regular-people") -- Simpler keymaps for vim-sexp
		use("tridactyl/vim-tridactyl") -- Tridactyl config file support
		use("aklt/plantuml-syntax") -- PlantUML support
		use("cdelledonne/vim-cmake") -- CMake integration

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Treesitter integration
		use("nvim-treesitter/playground") -- TSPlaygroundToggle - access treesitter data

		-- LSP
		use("neovim/nvim-lspconfig") -- Easy LSP Config
		use("alexaandru/nvim-lspupdate") -- Easy install and update for many LSP servers
		use("hrsh7th/cmp-nvim-lsp") -- LSP source for cmp
		use("hrsh7th/cmp-buffer") -- Buffer source for nvim-cmp
		use("hrsh7th/cmp-path") -- Path source for nvim-cmp
		use("hrsh7th/cmp-nvim-lua") -- Nvim-Lua source for nvim-cmp
		use("hrsh7th/cmp-omni") -- omnifunc source for nvim-cmp
		use("hrsh7th/nvim-cmp") -- completion integration
		use("jose-elias-alvarez/null-ls.nvim") -- Linting and formatting

		-- LSP language specific
		use("tjdevries/nlua.nvim") -- Built-in Lua integration with LSP
		use("akinsho/flutter-tools.nvim") -- Additional flutter integrations
		use("mfussenegger/nvim-jdtls") -- Additional java integrations

		-- Lua support
		use("nvim-lua/popup.nvim") -- Popup API integration - needed for some plugins
		use("nvim-lua/plenary.nvim") -- Lua helpers

		-- Telescope
		use("nvim-telescope/telescope.nvim") -- Fuzzy searcher
		use("nvim-telescope/telescope-dap.nvim") -- DAP integration for Telescope
	end,
})