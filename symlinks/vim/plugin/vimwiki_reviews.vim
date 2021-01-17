" -----------------------------------------------------------------------------
"     - Vimwiki extensions for working with weekly/monthly/yearly reviews -
"
"     DEPENDS ON VIMWIKI PLUGIN
" -----------------------------------------------------------------------------

" Gets path to reviews dir of provided vimwiki (by index)
function! s:GetReviewsDir(...)
	if a:0 == 0
		let l:vimwiki = g:vimwiki_list[0]
	else
		let l:vimwiki = g:vimwiki_list[str2nr(a:1) - 1]
	endif

	return l:vimwiki.path . 'reviews/'
endfunction

" Finds review template path for provided review type
function! s:GetReviewTemplatePath(vimwiki_reviews_path, review_type)
	return a:vimwiki_reviews_path . 'template-' . a:review_type . '.md'
endfunction

" Edits weekly review template
function! s:OpenReviewWeeklyTemplate(...)
	let reviews_dir = call('s:GetReviewsDir', a:000)
	execute 'edit ' . s:GetReviewTemplatePath(l:reviews_dir, 'week')
endfunction

" Edits monthly review template
function! s:OpenReviewMonthlyTemplate(...)
	let reviews_dir = call('s:GetReviewsDir', a:000)
	execute 'edit ' . s:GetReviewTemplatePath(l:reviews_dir, 'month')
endfunction

" Edits yearly review template
function! s:OpenReviewYearlyTemplate(...)
	let reviews_dir = call('s:GetReviewsDir', a:000)
	execute 'edit ' . s:GetReviewTemplatePath(l:reviews_dir, 'year')
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
function! s:ReadReviewTemplateIntoBuffer(vimwiki_reviews_path, review_type)
	let template_path = s:GetReviewTemplatePath(a:vimwiki_reviews_path, a:review_type)
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
function! s:VimwikiWeeklyReview(...)
	let reviews_dir = call('s:GetReviewsDir', a:000)
	let days_to_sunday = 7 - str2nr(strftime('%u'))
	let week_date = strftime('%Y-%m-%d', localtime() + l:days_to_sunday * 24 * 60 * 60)
	let file_name = l:reviews_dir . l:week_date . '-week.md'
	let exists = filereadable(glob(l:file_name))
	execute 'edit ' . l:file_name
	if exists == v:false
		call s:ReadReviewTemplateIntoBuffer(l:reviews_dir, 'week')
		execute '%substitute/%date%/' . l:week_date
	endif
endfunction


" Open past month monthly review file
" Created buffer is dated to previous month
" Previous month is calculated in an erroneous way
" 28 days are subtracted from current time to get previous month
function! s:VimwikiMonthlyReview(...)
	let reviews_dir = call('s:GetReviewsDir', a:000)
	let month_time = localtime() - 28 * 24 * 60 * 60
	let month_date = strftime('%Y-%m', l:month_time)
	let file_name = l:reviews_dir . l:month_date .'-month.md'
	let exists = filereadable(glob(l:file_name))
	execute 'edit ' . l:file_name
	if exists == v:false
		call s:ReadReviewTemplateIntoBuffer(l:reviews_dir, 'month')
		execute '%substitute/%date%/' . strftime('%Y %B', l:month_time)
	endif
endfunction

" Open past year yearly review file
" Created buffer is dated to previous year
function! s:VimwikiYearlyReview(...)
	let reviews_dir = call('s:GetReviewsDir', a:000)
	let year_date = (str2nr(strftime('%Y')) - 1)
	let file_name = l:reviews_dir . l:year_date .'-year.md'
	let exists = filereadable(glob(l:file_name))
	execute 'edit ' . l:file_name
	if exists == v:false
		call s:ReadReviewTemplateIntoBuffer(l:reviews_dir, 'year')
		execute '%substitute/%date%/' . l:year_date
	endif
endfunction

" Open reviews index file
function! s:VimwikiReviewIndex(...)
	let reviews_dir = call('s:GetReviewsDir', a:000)
	execute 'edit ' . l:reviews_dir . 'reviews.md'
endfunction

command! -nargs=? VimwikiWeeklyReview :call s:VimwikiWeeklyReview(<f-args>)
command! -nargs=? VimwikiWeeklyTemplate :call s:OpenReviewWeeklyTemplate(<f-args>)
command! -nargs=? VimwikiMonthlyReview :call s:VimwikiMonthlyReview(<f-args>)
command! -nargs=? VimwikiMonthlyTemplate :call s:OpenReviewMonthlyTemplate(<f-args>)
command! -nargs=? VimwikiYearlyReview :call s:VimwikiYearlyReview(<f-args>)
command! -nargs=? VimwikiYearlyTemplate :call s:OpenReviewYearlyTemplate(<f-args>)
command! -nargs=? VimwikiReviewIndex :call s:VimwikiReviewIndex(<f-args>)

nnoremap <Leader>wrw :VimwikiWeeklyReview<CR>
nnoremap <Leader>wrtw :VimwikiWeeklyTemplate<CR>
nnoremap <Leader>wrm :VimwikiMonthlyReview<CR>
nnoremap <Leader>wrtm :VimwikiMonthlyTemplate<CR>
nnoremap <Leader>wry :VimwikiYearlyReview<CR>
nnoremap <Leader>wrty :VimwikiYearlyTemplate<CR>
nnoremap <Leader>wri :VimwikiReviewIndex<CR>
