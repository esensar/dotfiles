" -----------------------------------------------------------------------------
"     - vim-grepper configuration -
" -----------------------------------------------------------------------------

let g:grepper       = {}
let g:grepper.tools = ['rg', 'git', 'grep']

" Search for the current word (similar to *)
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

command! -nargs=0 TODO GrepperGrep TODO
