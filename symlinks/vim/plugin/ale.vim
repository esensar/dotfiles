" -----------------------------------------------------------------------------
"     - ALE Plugin configuration -
" -----------------------------------------------------------------------------

" ALE Options
let g:ale_disable_lsp = 1 " Disable LSP, we have other stuff for that
let g:ale_fix_on_save = 1 " Default

" ALE Linters configuration
let g:ale_linters        = {}
let g:ale_linters.python = ['flake8']
let g:ale_linters.kotlin = ['ktlint']

" ALE Fixers configuration
let g:ale_fixers        = {}
let g:ale_fixers['*']   = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.python = ['autopep8', 'isort']

" Warnings navigation
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
