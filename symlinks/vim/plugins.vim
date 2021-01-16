if &compatible
  set nocompatible
endif

" -----------------------------------------------------------------------------
"     - Prepare Plug.vim -
" -----------------------------------------------------------------------------
if !has('win32') && !has('win64')
   let $PLUGLOCATION = $VIMHOME.'/autoload/plug.vim'
   if has('nvim')
      let $PLUGLOCATION = $NVIMHOME.'/site/autoload/plug.vim'
   endif
   if empty(glob('$PLUGLOCATION'))
      silent !curl -fLo $PLUGLOCATION --create-dirs
               \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      if empty($MYVIMRC)
         autocmd VimEnter * PlugInstall --sync | source $HOME . '.vimrc'
      else
         autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
      endif
   endif
endif

if empty($MY_VIM_HOME)
  call plug#begin($VIMHOME . '/plugged')
else
  call plug#begin($MY_VIM_HOME . '/plugged')
endif

" -----------------------------------------------------------------------------
"     - General -
" -----------------------------------------------------------------------------
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'vim-scripts/utl.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'direnv/direnv.vim'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-speeddating'

" -----------------------------------------------------------------------------
"     - Autocompletion -
" -----------------------------------------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'

" -----------------------------------------------------------------------------
"     - Tools -
" -----------------------------------------------------------------------------
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'vim-test/vim-test'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-projectionist'

" -----------------------------------------------------------------------------
"     - Vim improvements -
" -----------------------------------------------------------------------------
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'

" -----------------------------------------------------------------------------
"     - Snippets -
" -----------------------------------------------------------------------------
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" -----------------------------------------------------------------------------
"     - Language support -
" -----------------------------------------------------------------------------
Plug 'sheerun/vim-polyglot'
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-rails'
Plug 'mattn/emmet-vim'
Plug 'vimwiki/vimwiki'

call plug#end()

filetype plugin indent on
syntax enable
