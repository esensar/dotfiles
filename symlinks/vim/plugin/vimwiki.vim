" Must be set up before vimwiki plugin is initialized, can't be in after
let personal_wiki = {}
let personal_wiki.path = '~/doc/vimwiki/'
let personal_wiki.ext = '.md'
let personal_wiki.index = 'Home'
let personal_wiki.syntax = 'markdown'
let personal_wiki.auto_diary_index = 1
let personal_wiki.auto_generate_links = 1
let personal_wiki.auto_toc = 1

let g:vimwiki_list = [personal_wiki]

" Disable vimwiki filetype on all markdown files
let g:vimwiki_global_ext = 0

" Prettier checkboxes
let g:vimwiki_listsyms = '✗○◐●✓'
