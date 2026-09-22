if executable('lspmux')
    call lsp_settings#set('rust-analyzer', 'cmd', 'lspmux')
    call lsp_settings#set('rust-analyzer', 'workspace-config', 
                \ {'rust-analyzer': {
                \ 'check': { 'command': 'clippy' },
                \ 'checkonSave': v:true,
                \ 'diagnostics': { 'enable': v:true },
                \ 'procMacro': { 'enable': v:true },
                \ 'hoverActions': { 'enable': v:false },
                \ 'cargo': { 'features': 'all' }
                \ }})
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [w <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]w <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <A-k> <plug>(lsp-signature-help)
    nmap <buffer> k <plug>(lsp-signature-help)
    " " no plug provided for insert mode, so copying the code
    imap <buffer> <A-k> <c-o>:<c-u>call lsp#ui#vim#signature_help#get_signature_help_under_cursor()<cr>
    " imap <buffer> k <c-o>:<c-u>call lsp#ui#vim#signature_help#get_signature_help_under_cursor()<cr>
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
    nnoremap <buffer>  :LspCodeAction<CR>
    nnoremap <buffer> <A-CR> :LspCodeAction<CR>

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

function! s:asyncomplete_toggle()
    if get(b:, 'asyncomplete_enable', 0) == 1
        call asyncomplete#disable_for_buffer()
    else
        call asyncomplete#enable_for_buffer()
    endif
endfunction

function! s:lsp_disable()
    :LspStopServer
    call lsp#disable()
endfunction

command! AsyncompleteEnable call asyncomplete#enable_for_buffer()
command! AsyncompleteDisable call asyncomplete#disable_for_buffer()
command! LspEnable call lsp#enable()
command! LspDisable call <SID>lsp_disable()


nnoremap [oac :call asyncomplete#enable_for_buffer()<CR>
nnoremap ]oac :call asyncomplete#enable_for_buffer()<CR>
nnoremap yoac :call <SID>asyncomplete_toggle()<CR>
nnoremap [oal :call lsp#enable()<CR>
nnoremap ]oal :call <SID>lsp_disable()<CR>
