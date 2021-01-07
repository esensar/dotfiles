" Vim compiler file
" Compiler:         Elixir Script Compiler

if exists('current_compiler')
	finish
endif
let current_compiler = "elixir"

let s:save_cpo = &cpo
set cpo&vim

if exists(':CompilerSet') != 2
	command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=elixir\ %

let &cpo = s:save_cpo
unlet s:save_cpo
