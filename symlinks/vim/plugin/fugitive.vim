" -----------------------------------------------------------------------------
"     - Fugitive.vim setup and extra mappings -
" -----------------------------------------------------------------------------

" Shorcut to push directly to current branch on origin
" Similar to `ggpush` in fish config
function! s:PushOrigin()
	execute 'Gpush origin ' . FugitiveHead()
endfunction

" Generates url for creating PR for current branch
" Tested only with github.com
" Works regardless of ssh or https for origin config
" Hardcoded to use 'origin' remote
function! s:GetPrUrl()
	let origin_url = fugitive#RemoteUrl('origin')
	let origin_url = substitute(l:origin_url, '\.git$', '', '')
	let origin_url = substitute(l:origin_url, ':', '/', '')
	let origin_url = substitute(l:origin_url, 'git@', 'https://', '')
	let pr_url = l:origin_url . '/compare/' . FugitiveHead() . '?expand=1'
	return l:pr_url
endfunction

" Prints current branches PR url (not saved to :messages)
" Makes it easy to use terminal for opening url on click
function! s:PrintPrUrl()
	echo s:GetPrUrl()
endfunction

" Copies current branches PR url to system clipboard
function! s:CopyPrUrl()
	let @+ = s:GetPrUrl()
endfunction

" Opens current banches PR url in default browser
" Utilizes netrw browse, meaning it should behave same as netrw
function! s:OpenNewPr()
	call netrw#BrowseX(s:GetPrUrl(), 0)
endfunction

command! -nargs=0 Ggpush :call s:PushOrigin()
command! -nargs=0 Gpr :call s:OpenNewPr()
command! -nargs=0 Gpropen :call s:OpenNewPr()
command! -nargs=0 Gprprint :call s:PrintPrUrl()
command! -nargs=0 Gprcopy :call s:CopyPrUrl()
