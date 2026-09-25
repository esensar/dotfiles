" -----------------------------------------------------------------------------
"     - Hare file plugin -
" -----------------------------------------------------------------------------

setlocal cc=+1 foldmethod=syntax foldminlines=4 keywordprg=:Haredoc

let b:undo_ftplugin .= "|setlocal cc< foldmethod< foldminlines< keywordprg<"
