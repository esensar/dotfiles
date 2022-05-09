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
      autocmd VimEnter * PlugInstall --sync | source $HOME . '.vimrc'
   endif
endif

call plug#begin($VIMHOME . '/plugged')

" -----------------------------------------------------------------------------
"     - General -
" -----------------------------------------------------------------------------
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'mhinz/vim-grepper'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-speeddating'

" -----------------------------------------------------------------------------
"     - Autocompletion -
" -----------------------------------------------------------------------------
Plug 'ervandew/supertab'

" -----------------------------------------------------------------------------
"     - Tools -
" -----------------------------------------------------------------------------
Plug 'tpope/vim-dispatch'
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
Plug 'vimwiki/vimwiki'
Plug 'esensar/vimwiki-reviews'
Plug 'ledger/vim-ledger'

call plug#end()

filetype plugin indent on
syntax enable
