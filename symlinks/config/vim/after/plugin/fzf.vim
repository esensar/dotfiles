" Map FZF to CtrlP
nnoremap <C-P> :GFiles<CR>
nnoremap  :Rg<CR>
nnoremap <C-A-F> :Rg<CR>

" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

let s:fzf_pj_source = 'find "$HOME/src" -mindepth 3 -maxdepth 6 -type d -execdir test -d {}/.git ";" -print -prune | awk -F "$HOME/src" "{print $2}"'
command! PJ call fzf#run(fzf#wrap({'source': s:fzf_pj_source, 'sink': 'tcd'}))
command! GPJ call fzf#run(fzf#wrap({'source': s:fzf_pj_source, 'sink': 'cd'}))
command! LPJ call fzf#run(fzf#wrap({'source': s:fzf_pj_source, 'sink': 'lcd'}))
