return require('packer').startup {
   function(use)
      use 'wbthomason/packer.nvim'

      -- General plugins
      use 'tpope/vim-sensible'
      use 'tpope/vim-endwise'
      use 'tpope/vim-surround'
      use 'tpope/vim-fugitive'
      use 'tpope/vim-vinegar'
      use 'tpope/vim-obsession'
      use 'tpope/vim-dadbod'
      use 'airblade/vim-gitgutter'
      use 'godlygeek/tabular'
      use { 'Shougo/vimproc.vim', run = 'make' }
      use 'vim-scripts/utl.vim'
      use { 'mbbill/undotree', cmd = 'UndotreeToggle' }
      use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
      use 'junegunn/fzf.vim'
      use 'mhinz/vim-grepper'
      use 'direnv/direnv.vim'
      use 'tpope/vim-speeddating'
      use 'doums/darcula'

      -- Tools
      use 'tpope/vim-dispatch'
      use 'radenling/vim-dispatch-neovim'
      use 'vim-test/vim-test'
      use 'dense-analysis/ale'
      use 'tpope/vim-projectionist'
      use 'ervandew/supertab'

      -- Vim improvements
      use 'wellle/targets.vim'
      use 'tpope/vim-unimpaired'
      use 'tpope/vim-repeat'
      use 'tpope/vim-commentary'
      use 'tpope/vim-sleuth'

      -- Snippets
      if vim.g.loaded_python3_provider ~= 0
         then
         use 'SirVer/ultisnips'
         use 'honza/vim-snippets'
      end

      -- Language support
      use 'sheerun/vim-polyglot'
      use 'c-brenn/phoenix.vim'
      use 'tpope/vim-rails'
      use 'tpope/vim-salve'
      use 'tpope/vim-fireplace'
      use 'vimwiki/vimwiki'
      use 'ledger/vim-ledger'

      -- Treesitter
      use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
      -- use { 'npxbr/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } }

      -- LSP
      -- use 'tjdevries/nlua.nvim'
      use 'neovim/nvim-lspconfig'
      use 'alexaandru/nvim-lspupdate'
      use 'nvim-lua/completion-nvim'
      use 'nvim-treesitter/completion-treesitter'
      use 'nvim-lua/lsp_extensions.nvim'

      -- Extras
      use 'nathunsmitty/nvim-ale-diagnostic'

      -- Lua support
      use 'tjdevries/astronauta.nvim'
      use 'nvim-lua/popup.nvim'
      use 'nvim-lua/plenary.nvim'
   end
}
