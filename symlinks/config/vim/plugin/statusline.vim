" -----------------------------------------------------------------------------
"     - Statusline setup -
" -----------------------------------------------------------------------------

function s:UpdateColors()
    let ctermbg = synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'cterm')
    let guibg = synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'gui')
    let idguifg1 = synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui')
    let idctermfg1 = synIDattr(synIDtrans(hlID('Function')), 'fg', 'cterm')
    " Green in gruvbox
    exec 'hi User1 guifg=' . l:idguifg1 .
                \' ctermfg=' . l:idctermfg1 .
                \' guibg=' . l:guibg .
                \' ctermbg=' . l:ctermbg .
                \' cterm=bold gui=bold'
    let idguifg2 = synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'gui')
    let idctermfg2 = synIDattr(synIDtrans(hlID('WarningMsg')), 'fg', 'cterm')
    " Red in gruvbox
    exec 'hi User2 guifg=' . l:idguifg2 .
                \' ctermfg=' . l:idctermfg2 .
                \' guibg=' . l:guibg .
                \' ctermbg=' . l:ctermbg .
                \' cterm=bold gui=bold'
    let idguifg3 = synIDattr(synIDtrans(hlID('MoreMsg')), 'fg', 'gui')
    let idctermfg3 = synIDattr(synIDtrans(hlID('MoreMsg')), 'fg', 'cterm')
    " Yellow in gruvbox
    exec 'hi User3 guifg=' . l:idguifg3 .
                \' ctermfg=' . l:idctermfg3 .
                \' guibg=' . l:guibg .
                \' ctermbg=' . l:ctermbg .
                \' cterm=bold gui=bold'
    let idguifg4 = synIDattr(synIDtrans(hlID('Identifier')), 'fg', 'gui')
    let idctermfg4 = synIDattr(synIDtrans(hlID('Identifier')), 'fg', 'cterm')
    " Blue in gruvbox
    exec 'hi User4 guifg=' . l:idguifg4 .
                \' ctermfg=' . l:idctermfg4 .
                \' guibg=' . l:guibg .
                \' ctermbg=' . l:ctermbg .
                \' cterm=bold gui=bold'
    let idguifg5 = synIDattr(synIDtrans(hlID('Number')), 'fg', 'gui')
    let idctermfg5 = synIDattr(synIDtrans(hlID('Number')), 'fg', 'cterm')
    " Blue in gruvbox
    exec 'hi User5 guifg=' . l:idguifg5 .
                \' ctermfg=' . l:idctermfg5 .
                \' guibg=' . l:guibg .
                \' ctermbg=' . l:ctermbg .
                \' cterm=bold gui=bold'
endfunction

augroup statuslineconf
    autocmd!
    autocmd ColorScheme * call s:UpdateColors()
augroup END

call s:UpdateColors()


" Checks file type to add a pretty glyph if available
function s:GetFileType()
    let l:filetype = getwinvar(g:statusline_winid, '&filetype')
    if l:filetype ==# "rust"
        return "%2*%*"
    elseif l:filetype ==# "c"
        return "%4*%*"
    elseif l:filetype ==# "cs"
        return "%4*%*"
    elseif l:filetype ==# "python"
        return "%3*%*"
    elseif l:filetype ==# "javascript"
        return ""
    elseif l:filetype ==# "typescript"
        return "%4*%*"
    elseif l:filetype ==# "vim"
        return "%1*%*"
    elseif l:filetype ==# "clojure"
        return ""
    elseif l:filetype ==# "html"
        return ""
    elseif l:filetype ==# "haskell"
        return ""
    elseif l:filetype ==# "markdown"
        return ""
    elseif l:filetype ==# "org"
        return ""
    elseif l:filetype ==# "scss"
        return ""
    elseif l:filetype ==# "scala"
        return ""
    elseif l:filetype ==# "elixir"
        return "%5*%*"
    elseif l:filetype ==# "kotlin"
        return "%2*洞%*"
    elseif l:filetype ==# "yml"
        return ""
    elseif l:filetype ==# "toml"
        return ""
    elseif l:filetype ==# "json"
        return ""
    elseif l:filetype ==# "timelog"
        return "%1*󰔠%*"
    elseif l:filetype ==# "timelogreport"
        return "%1*󰔠%*"
    elseif l:filetype ==# "fugitive"
        return "%4*%*"
    elseif l:filetype ==# "help"
        return "Docs"
    elseif l:filetype ==# "man"
        return "Docs"
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
    elseif mode() == "t"
        return "%2*T%*"
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
    let l:counts = lsp#get_buffer_diagnostics_counts()

    let l:total = l:counts['error'] + l:counts['warning'] + l:counts['information'] + l:counts['hint']
    if l:total == 0 
        return '%1* OK %*'
    endif
    let l:result = ''
    if l:counts['hint'] != 0
        let l:result .= printf(' %dH', l:counts['hint'])
    endif
    if l:counts['information'] != 0
        let l:result .= printf(' %dI', l:counts['information'])
    endif
    if l:counts['warning'] != 0
        let l:result .= printf(' %%3*%dW%%*', l:counts['warning'])
    endif
    if l:counts['error'] != 0
        let l:result .= printf(' %%2*%dE%%*', l:counts['error'])
    endif
    return l:result
endfunction

function! s:LspStatus() abort
    let l:progress = lsp#get_progress()

    if empty(l:progress)
        return ''
    endif

    let l:status = l:progress[0]
    return printf(' %%2*%s %d%%%%*', l:status['message'], l:status['percentage'])
endfunction

function GetStatusLine()
    let l:buftype = getwinvar(g:statusline_winid, '&buftype')
    let l:status_line_left = " " . s:GetMode() . " "
    if exists('g:loaded_fugitive') && empty(l:buftype)
        let l:fugitive_head = FugitiveHead()
        if strlen(l:fugitive_head)
            let l:status_line_left .= "%4* " . l:fugitive_head . "%*"
        endif
    endif
    let l:status_line_left .= " %f" " Filename
    let l:status_line_left .= " %1*%M%*" " Modified
    let l:status_line_left .= " %2*%r%*" " Read only
    let l:status_line_left .= s:PasteForStatusline()
    if exists('g:loaded_lsp') && empty(l:buftype)
        let l:status_line_left .= s:LspStatus()
    endif
    let l:status_line_right = "%=   " " Align right statusline
    if exists('g:loaded_lsp') && empty(l:buftype)
        let l:status_line_right .= s:LinterStatus() " LSP diagnostics
    endif
    let l:status_line_right .= " %2c:%3l/%3L (%3p%%) " " col, line, tot. lines
    let l:status_line_right .= s:GetFileType() . " " " File type
    return l:status_line_left . l:status_line_right
endfunction
set statusline=%!GetStatusLine()

augroup statusline_updates
  autocmd!
  autocmd User lsp_diagnostics_updated redrawstatus
  autocmd User lsp_progress_updated redrawstatus
augroup END
