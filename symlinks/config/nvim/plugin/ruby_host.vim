" -----------------------------------------------------------------------------
"     - Neovim ruby host -
" -----------------------------------------------------------------------------
if !has('win32')
	let g:ruby_host_prog = '~/.asdf/shims/ruby'
else
	let g:ruby_host_prog = '~/scoop/shims/ruby'
endif
