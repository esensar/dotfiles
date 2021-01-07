" -----------------------------------------------------------------------------
"     - Undo configuration -
" -----------------------------------------------------------------------------
set undofile
let &undodir=$VIMHOME.'/undodir'

" Disable persistent undofile for temporary files!
augroup undoconf
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
