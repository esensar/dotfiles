setlocal ts=2 sts=2 sw=2 expandtab autoindent
let b:undo_ftplugin .= '|setlocal ts< sts< sw< expandtab< autoindent<'

function s:FireplaceStartAndConnect()
	let port = luaeval('math.random(35000, 39999)')
	silent execute "Dispatch lein repl :start :port " . l:port
	sleep 3
	execute "FireplaceConnect nrepl://localhost:" . l:port
endfunction

command! -nargs=0 FireplaceStartLeinRepl call <SID>FireplaceStartAndConnect()
