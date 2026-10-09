" -----------------------------------------------------------------------------
"     - Fugitive.vim setup and extra mappings -
" -----------------------------------------------------------------------------

" Generates url for creating PR for current branch
" Tested only with github.com
" Works regardless of ssh or https for origin config
" Hardcoded to use 'origin' remote
function! s:GetPrUrl(...)
	let origin_url = FugitiveRemoteUrl('origin')
	let l:origin_url = substitute(l:origin_url, '\.git$', '', '')
	let l:origin_url = substitute(l:origin_url, ':', '/', '')
	let l:origin_url = substitute(l:origin_url, 'git@', 'https://', '')

	" Remove prefix if it is available, for some of common git services
	let common_services = ['github.com', 'bitbucket.org', 'gitlab.com', 'codeberg.org']
	for service in l:common_services
		if (l:origin_url =~ l:service)
			" Common mechanism for managing multiple SSH keys
			let l:origin_url = substitute(l:origin_url, '://.*' . l:service, '://' . l:service, '')
		endif
	endfor

	if a:0 == 0
		let pr_url = l:origin_url . '/compare/' . FugitiveHead() . '?expand=1'
	else
		let pr_url = l:origin_url . '/compare/' . a:1 . '...' . FugitiveHead() . '?expand=1'
	endif
	return l:pr_url
endfunction

" Prints current branches PR url (not saved to :messages)
" Makes it easy to use terminal for opening url on click
function! s:PrintPrUrl(...)
	echo call('s:GetPrUrl', a:000)
endfunction

" Copies current branches PR url to system clipboard
function! s:CopyPrUrl(...)
	let @+ = call('s:GetPrUrl', a:000)
endfunction

" Opens current banches PR url in default browser
" Utilizes netrw browse, meaning it should behave same as netrw
function! s:OpenNewPr(...)
	call netrw#BrowseX(call('s:GetPrUrl', a:000), 0)
endfunction

command! -nargs=? Gpropen :call s:OpenNewPr(<f-args>)
command! -nargs=? Gpr Gpropen <args>
command! -nargs=? Gprprint :call s:PrintPrUrl(<f-args>)
command! -nargs=? Gprcopy :call s:CopyPrUrl(<f-args>)
