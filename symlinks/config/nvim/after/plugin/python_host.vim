" -----------------------------------------------------------------------------
"     - Neovim python host -
"     Explicit declaration of python host program to "prevent suprises"
" -----------------------------------------------------------------------------
if !has('win32')
	let g:python_host_prog  = $HOME.'/.asdf/shims/python2'
	let g:python3_host_prog = $HOME.'/.asdf/shims/python3'
else
	let g:python_host_prog  = $HOME.'/scoop/shims/python2'
	let g:python3_host_prog = $HOME.'/scoop/shims/python3'
endif
