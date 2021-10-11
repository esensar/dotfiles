" -----------------------------------------------------------------------------
"     - Ledger file plugin -
" -----------------------------------------------------------------------------

augroup ledgerconf
	autocmd!
	autocmd BufWritePre *.journal LedgerAlignBuffer
augroup END
