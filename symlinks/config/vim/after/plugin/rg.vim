if exists("g:loaded_rg") || &cp | finish | endif

let g:loaded_rg = 1

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

