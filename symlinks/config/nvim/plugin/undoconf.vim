" -----------------------------------------------------------------------------
"     - Undo configuration -
" -----------------------------------------------------------------------------
set undofile

" Disable persistent undofile for temporary files!
augroup undoconf
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
