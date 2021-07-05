" -----------------------------------------------------------------------------
"     - Python file plugin -
" -----------------------------------------------------------------------------

" Without this, weird issues occurred with asdf + direnv + python virtualenv
setlocal shell=/bin/sh

setlocal textwidth=79
setlocal cc=+1

let b:undo_ftplugin .= "|setlocal shell< textwidth< cc<"
