" -----------------------------------------------------------------------------
"     - Vimwiki extensions for working with weekly/monthly/yearly reviews -
"
"     DEPENDS ON VIMWIKI PLUGIN
" -----------------------------------------------------------------------------

" Gets path to reviews dir of provided vimwiki (by index)
function! GetReviewsDir(vimwiki_index)
	if a:vimwiki_index == 0
		let l:current_index = vimwiki#vars#get_bufferlocal('wiki_nr')
		if (l:current_index < 0)
			let l:current_index = 0
		end

		let l:vimwiki = g:vimwiki_list[l:current_index]
	else
		let l:vimwiki = g:vimwiki_list[a:vimwiki_index - 1]
	endif

	return l:vimwiki.path . 'reviews/'
endfunction

" Finds review template path for provided review type
function! GetReviewTemplatePath(vimwiki_reviews_path, review_type)
	return a:vimwiki_reviews_path . 'template-' . a:review_type . '.md'
endfunction

" Edits weekly review template
function! OpenReviewWeeklyTemplate(vimwiki_index)
	let reviews_dir = GetReviewsDir(a:vimwiki_index)
	execute 'edit ' . GetReviewTemplatePath(l:reviews_dir, 'week')
endfunction

" Edits monthly review template
function! OpenReviewMonthlyTemplate(vimwiki_index)
	let reviews_dir = GetReviewsDir(a:vimwiki_index)
	execute 'edit ' . GetReviewTemplatePath(l:reviews_dir, 'month')
endfunction

" Edits yearly review template
function! OpenReviewYearlyTemplate(vimwiki_index)
	let reviews_dir = GetReviewsDir(a:vimwiki_index)
	execute 'edit ' . GetReviewTemplatePath(l:reviews_dir, 'year')
endfunction

" Reads template for provided review type into current buffer
" Uses overrides in form of files in reviews directory
" Looks for file named template-{review_type}.md:
"  - template-week.md
"  - template-month.md
"  - template-year.md
" Templates can use variables using %variable% syntax
" Currently supported variables are:
"  - %date% (Puts different date based on review type)
function! ReadReviewTemplateIntoBuffer(vimwiki_reviews_path, review_type)
	let template_path = GetReviewTemplatePath(a:vimwiki_reviews_path, a:review_type)
	if filereadable(glob(l:template_path))
		execute 'read ' . l:template_path
	else
		if a:review_type == 'week'
			call setline(1, '# %date% Weekly Review')
		elseif a:review_type == 'month'
			call setline(1, '# %date% Monthly Review')
		elseif a:review_type == 'year'
			call setline(1, '# %date% Yearly Review')
		endif
	endif
endfunction

" Open current week weekly review file
" Created buffer is dated to Sunday of current week
" Opens current week because Sunday is good time to do this review
function! VimwikiWeeklyReview(vimwiki_index)
	let reviews_dir = GetReviewsDir(a:vimwiki_index)
	let days_to_sunday = 7 - str2nr(strftime('%u'))
	let week_date = strftime('%Y-%m-%d', localtime() + l:days_to_sunday * 24 * 60 * 60)
	let file_name = l:reviews_dir . l:week_date . '-week.md'
	let exists = filereadable(glob(l:file_name))
	execute 'edit ' . l:file_name
	if exists == v:false
		call ReadReviewTemplateIntoBuffer(l:reviews_dir, 'week')
		execute '%substitute/%date%/' . l:week_date
	endif
endfunction


" Open past month monthly review file
" Created buffer is dated to previous month
" Previous month is calculated in an erroneous way
" 28 days are subtracted from current time to get previous month
function! VimwikiMonthlyReview(vimwiki_index)
	let reviews_dir = GetReviewsDir(a:vimwiki_index)
	let month_time = localtime() - 28 * 24 * 60 * 60
	let month_date = strftime('%Y-%m', l:month_time)
	let file_name = l:reviews_dir . l:month_date .'-month.md'
	let exists = filereadable(glob(l:file_name))
	execute 'edit ' . l:file_name
	if exists == v:false
		call ReadReviewTemplateIntoBuffer(l:reviews_dir, 'month')
		execute '%substitute/%date%/' . strftime('%Y %B', l:month_time)
	endif
endfunction

" Open past year yearly review file
" Created buffer is dated to previous year
function! VimwikiYearlyReview(vimwiki_index)
	let reviews_dir = GetReviewsDir(a:vimwiki_index)
	let year_date = (str2nr(strftime('%Y')) - 1)
	let file_name = l:reviews_dir . l:year_date .'-year.md'
	let exists = filereadable(glob(l:file_name))
	execute 'edit ' . l:file_name
	if exists == v:false
		call ReadReviewTemplateIntoBuffer(l:reviews_dir, 'year')
		execute '%substitute/%date%/' . l:year_date
	endif
endfunction

" Open reviews index file
function! VimwikiReviewIndex(vimwiki_index)
	let reviews_dir = GetReviewsDir(a:vimwiki_index)
	execute 'edit ' . l:reviews_dir . 'reviews.md'
endfunction

command! -count=0 VimwikiWeeklyReview :call VimwikiWeeklyReview(<count>)
command! -count=0 VimwikiWeeklyTemplate :call OpenReviewWeeklyTemplate(<count>)
command! -count=0 VimwikiMonthlyReview :call VimwikiMonthlyReview(<count>)
command! -count=0 VimwikiMonthlyTemplate :call OpenReviewMonthlyTemplate(<count>)
command! -count=0 VimwikiYearlyReview :call VimwikiYearlyReview(<count>)
command! -count=0 VimwikiYearlyTemplate :call OpenReviewYearlyTemplate(<count>)
command! -count=0 VimwikiReviewIndex :call VimwikiReviewIndex(<count>)

" TODO - Move functions to autoload
nnoremap <Leader>wrw <Cmd>call VimwikiWeeklyReview(v:count)<CR>
nnoremap <Leader>wrtw <Cmd>call OpenReviewWeeklyTemplate(v:count)<CR>
nnoremap <Leader>wrm <Cmd>call VimwikiMonthlyReview(v:count)<CR>
nnoremap <Leader>wrtm <Cmd>call OpenReviewMonthlyTemplate(v:count)<CR>
nnoremap <Leader>wry <Cmd>call VimwikiYearlyReview(v:count)<CR>
nnoremap <Leader>wrty <Cmd>call OpenReviewYearlyTemplate(v:count)<CR>
nnoremap <Leader>wri <Cmd>call VimwikiReviewIndex(v:count)<CR>
