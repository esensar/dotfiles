" -----------------------------------------------------------------------------
"     - UltiSnips configuration -
" -----------------------------------------------------------------------------

" Force ultisnips to use vim directory 
let g:UltiSnipsSnippetDirectories=[$VIMHOME."/UltiSnips"]
let g:UltiSnipsExpandOrJumpTrigger='<C-J>'
let g:UltiSnipsListSnippets='<C-A-J>'
let g:snips_author="Ensar Sarajčić"

" Based on https://github.com/SirVer/ultisnips/issues/886#issuecomment-406624947
function! UltiSnipsListSnippets(findstart, base) abort
	if empty(UltiSnips#SnippetsInCurrentScope(1))
		return ''
	endif

    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && (line[start - 1] =~ '\a')
            let start -= 1
        endwhile
        return start
    else
        " find classes starting with "a:base"
        let res = []
        for m in keys(g:current_ulti_dict_info)
            if m =~ '^' . a:base
				let n = {
					\ 'word': m,
					\ 'menu': g:current_ulti_dict_info[m]['description']
					\ }
                call add(res, n)
            endif
        endfor
        return res
    endif
endfunction
