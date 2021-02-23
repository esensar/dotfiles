" -----------------------------------------------------------------------------
"     - Statusline setup -
" -----------------------------------------------------------------------------

function s:UpdateColors()
    let ctermbg = synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'cterm')
    let guibg = synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'gui')
    let idguifg1 = synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui')
    let idctermfg1 = synIDattr(synIDtrans(hlID('Function')), 'fg', 'cterm')
    " Green in gruvbox
    exec 'hi User1 guifg=' . l:idguifg1 .
                \' guibg=' . l:guibg .
                \' cterm=bold gui=bold'
    if l:idctermfg1
        exec 'hi User1 ctermfg=' . l:idctermfg1
    endif
    let idguifg2 = synIDattr(synIDtrans(hlID('ErrorMsg')), 'fg', 'gui')
    let idctermfg2 = synIDattr(synIDtrans(hlID('ErrorMsg')), 'fg', 'cterm')
    " Red in gruvbox
    exec 'hi User2 guifg=' . l:idguifg2 .
                \' guibg=' . l:guibg .
                \' cterm=bold gui=bold'
    if l:idctermfg2
        exec 'hi User2 ctermfg=' . l:idctermfg2
    endif
    let idguifg3 = synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
    let idctermfg3 = synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'cterm')
    " Yellow in gruvbox
    exec 'hi User3 guifg=' . l:idguifg3 .
                \' guibg=' . l:guibg .
                \' cterm=bold gui=bold'
    if l:idctermfg3
        exec 'hi User3 ctermfg=' . l:idctermfg3
    endif
    let idguifg4 = synIDattr(synIDtrans(hlID('Identifier')), 'fg', 'gui')
    let idctermfg4 = synIDattr(synIDtrans(hlID('Identifier')), 'fg', 'cterm')
    " Blue in gruvbox
    exec 'hi User4 guifg=' . l:idguifg4
                \' guibg=' . l:guibg .
                \' cterm=bold gui=bold'
    if l:idctermfg4
        exec 'hi User4 ctermfg=' . l:idctermfg4
    endif
    let idguifg5 = synIDattr(synIDtrans(hlID('Number')), 'fg', 'gui')
    let idctermfg5 = synIDattr(synIDtrans(hlID('Number')), 'fg', 'cterm')
    " Blue in gruvbox
    exec 'hi User5 guifg=' . l:idguifg5 .
                \' guibg=' . l:guibg .
                \' cterm=bold gui=bold'
    if l:idctermfg5
        exec 'hi User5 ctermfg=' . l:idctermfg5
    endif

    if l:ctermbg
        exec 'hi User1 ctermbg=' . l:ctermbg
        exec 'hi User2 ctermbg=' . l:ctermbg
        exec 'hi User3 ctermbg=' . l:ctermbg
        exec 'hi User4 ctermbg=' . l:ctermbg
        exec 'hi User5 ctermbg=' . l:ctermbg
    endif
endfunction

augroup statuslineconf
    autocmd!
    autocmd ColorScheme * call s:UpdateColors()
augroup END

call s:UpdateColors()


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
        return "N"
    elseif mode() == "i"
        return "%3*I%*"
    elseif mode() == "v"
        return "%1*V%*"
    elseif mode() == "V"
        return "%1*V.%*"
    elseif mode() == "\<C-V>"
        return "%1*VB%*"
    elseif mode() == "c"
        return "%4*C%*"
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
    let l:status_line_left = " " . s:GetMode() . " "
    if exists('g:loaded_fugitive')
        let l:fugitive_head = FugitiveHead()
        if strlen(l:fugitive_head)
            let l:status_line_left .= "%4* " . l:fugitive_head . "%*"
        endif
    endif
    let l:status_line_left .= " %f" " Filename
    let l:status_line_left .= " %1*%M%*" " Modified
    let l:status_line_left .= " %2*%r%*" " Read only
    let l:status_line_left .= s:PasteForStatusline()
    if exists('g:did_coc_loaded')
        let l:coc_status = coc#status()
        if strlen(l:coc_status)
            let l:status_line_left .= "%2*" . l:coc_status . "%*"
        endif
    endif
    let l:status_line_right = "%=   " " Align right statusline
    if exists('g:loaded_ale')
        let l:status_line_right .= s:LinterStatus() " ALE status
    endif
    let l:status_line_right .= " %2c:%3l/%3L (%3p%%) " " col, line, tot. lines
    let l:status_line_right .= s:GetFileType() . " " " File type
    return l:status_line_left . l:status_line_right
endfunction
set statusline=%!GetStatusLine()
