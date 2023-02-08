" Must be set up before vimwiki plugin is initialized, can't be in after
let personal_wiki = {}
let personal_wiki.path = '~/vimwiki/'
let personal_wiki.ext = '.md'
let personal_wiki.index = 'Home'
let personal_wiki.syntax = 'markdown'
let personal_wiki.auto_diary_index = 1
let personal_wiki.auto_generate_links = 1
let personal_wiki.auto_toc = 1

let work_wiki = {}
let work_wiki.path = '~/vimwiki_work/'
let work_wiki.index = 'Home'
let work_wiki.syntax = 'markdown'
let work_wiki.ext = '.md'
let work_wiki.auto_diary_index = 1
let work_wiki.auto_generate_links = 1
let work_wiki.auto_toc = 1

let test_wiki = {}
let test_wiki.path = '/tmp'

let g:vimwiki_list = [personal_wiki, work_wiki, test_wiki]

" Disable vimwiki filetype on all markdown files
let g:vimwiki_global_ext = 0

" Prettier checkboxes
let g:vimwiki_listsyms = '✗○◐●✓'

augroup VimwikiBufEnterMarkdown
	autocmd!
	autocmd BufEnter *.md setl syntax=markdown
augroup END


command! -count=0 -nargs=1 VimwikiOpenSubdirectoryIndex :lua require('esensar.vimwiki_extensions').open_subdirectory_index_file(<count>, <f-args>)
