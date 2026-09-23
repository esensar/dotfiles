let g:lsp_auto_enable = 0
let g:lsp_work_done_progress_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_prefix = " ‣ "
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_highlighs_insert_mode_enabled = 0
let g:lsp_hover_ui = 'preview'
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_diagnostics_float_insert_mode_enabled = 0
let g:asyncomplete_enable_for_all = 0
let g:asnycomplete_auto_completeopt = 0

function s:setup_quickpick_keymap() abort
	imap <buffer> <C-y> <Plug>(lsp-quickpick-accept)
	nmap <buffer> <C-y> <Plug>(lsp-quickpick-accept)
	imap <buffer> <CR> <Plug>(lsp-quickpick-accept)
	nmap <buffer> <CR> <Plug>(lsp-quickpick-accept)
	imap <silent> <buffer> <C-n> <Plug>(lsp-quickpick-move-next)
	nmap <silent> <buffer> <C-n> <Plug>(lsp-quickpick-move-next)
	imap <silent> <buffer> <C-j> <Plug>(lsp-quickpick-move-next)
	nmap <silent> <buffer> <C-j> <Plug>(lsp-quickpick-move-next)
	imap <silent> <buffer> <C-p> <Plug>(lsp-quickpick-move-previous)
	nmap <silent> <buffer> <C-p> <Plug>(lsp-quickpick-move-previous)
	imap <silent> <buffer> <C-k> <Plug>(lsp-quickpick-move-previous)
	nmap <silent> <buffer> <C-k> <Plug>(lsp-quickpick-move-previous)
	imap <silent> <buffer> <C-c> <Plug>(lsp-quickpick-cancel)
	map  <silent> <buffer> <C-c> <Plug>(lsp-quickpick-cancel)
	imap <silent> <buffer> <Esc> <Plug>(lsp-quickpick-cancel)
	map  <silent> <buffer> <Esc> <Plug>(lsp-quickpick-cancel)
	imap <silent> <buffer> <C-e> <Plug>(lsp-quickpick-cancel)
	map  <silent> <buffer> <C-e> <Plug>(lsp-quickpick-cancel)
endfunction

augroup lsp_quickpick_setup
	au!
	autocmd FileType lsp-quickpick-filter call <SID>setup_quickpick_keymap()
augroup END
