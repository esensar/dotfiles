if exists("g:loaded_lsp") || &cp | finish | endif

let g:loaded_lsp = 1

let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_prefix = " ‣ "
let g:lsp_diagnostics_float_cursor = 1

if executable('lspmux')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'lspmux',
        \ 'cmd': {server_info->['lspmux']},
        \ 'allowlist': ['rust'],
        \ 'workspace_config': {'rust-analyzer': {
        \ 'check': { 'command': 'clippy' },
        \ 'checkonSave': v:true,
        \ 'diagnostics': { 'enable': v:true },
        \ 'procMacro': { 'enable': v:true },
        \ 'hoverActions': { 'enable': v:false },
        \ 'cargo': { 'features': 'all' }
        \ }}})
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'blocklist': ['rust'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [w <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]w <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
    nnoremap <buffer>  :LspCodeAction<CR>

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
