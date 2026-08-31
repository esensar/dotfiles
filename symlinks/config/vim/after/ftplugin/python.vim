" -----------------------------------------------------------------------------
"     - Python file plugin -
" -----------------------------------------------------------------------------

" Without this, weird issues occurred with asdf + direnv + python virtualenv
setlocal shell=/bin/sh
let b:undo_ftplugin .= "|setlocal shell<"
