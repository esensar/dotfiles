" -----------------------------------------------------------------------------
"     - Ledger file plugin -
" -----------------------------------------------------------------------------

augroup ledgerconf
	autocmd!
	autocmd BufWritePre <buffer> LedgerAlignBuffer
augroup END
