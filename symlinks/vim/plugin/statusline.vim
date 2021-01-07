" -----------------------------------------------------------------------------
"     - Statusline setup -
" -----------------------------------------------------------------------------

" Configure user colors for proper focus management
hi! link User1 StatusLineGreenFg
hi! link User2 StatusLineRedFg
hi! link User3 StatusLineYellowFg
hi! link User4 StatusLineBlueFg
hi! link User5 StatusLinePurpleFg

" Checks file type to add a pretty glyph if available
function s:GetFileType()
    if &filetype ==# "rust"
        return "%2*%*"
    elseif &filetype ==# "c"
        return "%4*%*"
    elseif &filetype ==# "python"
        return "%3*%*"
    elseif &filetype ==# "javascript"
        return ""
    elseif &filetype ==# "typescript"
        return "%4*%*"
    elseif &filetype ==# "vim"
        return "%1*%*"
    elseif &filetype ==# "clojure"
        return ""
    elseif &filetype ==# "html"
        return ""
    elseif &filetype ==# "haskell"
        return ""
    elseif &filetype ==# "markdown"
        return ""
    elseif &filetype ==# "org"
        return ""
    elseif &filetype ==# "scss"
        return ""
    elseif &filetype ==# "scala"
        return ""
    elseif &filetype ==# "elixir"
        return "%5*%*"
    elseif &filetype ==# "kotlin"
        return "%2*洞%*"
    elseif &filetype ==# "yml"
        return ""
    elseif &filetype ==# "toml"
        return ""
    elseif &filetype ==# "json"
        return ""
    else
        return "%y"
endfunction

" Check current mode to add colorized mode
function s:GetMode()
    if mode() == "n"
        return " N "
    elseif mode() == "i"
        return "%3* I %*"
    elseif mode() == "v"
        return "%1* V %*"
    elseif mode() == "V"
        return "%1* V. %*"
    elseif mode() == "\<C-V>"
        return "%1* VB %*"
    elseif mode() == "c"
        return "%4* C %*"
    else
        return "[mode: " . mode() . "]"
endfunction

" Add basic [paste] if paste mode is enabled
function! s:PasteForStatusline()
    let paste_status = &paste
    if paste_status == 1
        return " [paste] "
    else
        return ""
    endif
endfunction

function! s:LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '%1*OK%*' : printf(
    \   '%%3*%dW%%* %%2*%dE%%*',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

function GetStatusLine()
    let l:status_line_left = s:GetMode()
    if exists('g:loaded_fugitive')
        let l:status_line_left .= "%4* " . FugitiveHead() . "%*"
    endif
    let l:status_line_left .= " %f" " Filename
    let l:status_line_left .= " %1*%M%*" " Modified
    let l:status_line_left .= " %2*%r%*" " Read only
    let l:status_line_left .= s:PasteForStatusline()
    if exists('g:did_coc_loaded')
        let l:status_line_left .= "%2*" . coc#status() . "%*"
    endif
    let l:status_line_right = "%=   " " Align right statusline
    if exists('g:loaded_ale')
        let l:status_line_right .= s:LinterStatus() " ALE status
    endif
    let l:status_line_right .= " %c:%l/%L (%p%%) " " col, line, tot. lines
    let l:status_line_right .= s:GetFileType() . " " " File type
    return l:status_line_left . l:status_line_right
endfunction
set statusline=%!GetStatusLine()
