setlocal ts=2 sts=2 sw=2 expandtab autoindent
let b:undo_ftplugin .= '|setlocal ts< sts< sw< expandtab< autoindent<'

compiler elixir
let b:undo_ftplugin .= '|compiler<'
