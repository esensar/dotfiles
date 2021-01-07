" -----------------------------------------------------------------------------
"     - Neovim python host -
"     Explicit declaration of python host program to "prevent suprises"
"
"     NEOVIM ONLY!
" -----------------------------------------------------------------------------
if has('nvim')
  let g:python_host_prog  = $HOME.'/.asdf/shims/python2'
  let g:python3_host_prog = $HOME.'/.asdf/shims/python3'
endif
