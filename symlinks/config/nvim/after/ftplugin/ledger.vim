" -----------------------------------------------------------------------------
"     - Ledger file plugin -
" -----------------------------------------------------------------------------

let g:ledger_date_format = '%Y-%m-%d'

augroup ledgerconf
	autocmd!
	autocmd BufWritePre <buffer> LedgerAlignBuffer
augroup END

nnoremap <buffer> <leader>lx <cmd>call ledger#entry()<CR>
noremap <silent><buffer> <leader>lc <cmd>call ledger#transaction_state_toggle(line('.'), ' *?!')<CR>
