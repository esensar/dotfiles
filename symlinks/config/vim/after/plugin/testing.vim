" -----------------------------------------------------------------------------
"     - Vim-test and general testing config -
" -----------------------------------------------------------------------------

" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

" Map test running commands
nmap <silent> <Leader>tn :TestNearest<CR>
nmap <silent> <Leader>tf :TestFile<CR>
nmap <silent> <Leader>ts :TestSuite<CR>
nmap <silent> <Leader>tl :TestLast<CR>
nmap <silent> <Leader>tg :TestVisit<CR>
