-------------------------------------------------------------------------------
--    - Vimwiki extensions for working with weekly/monthly/yearly reviews -
--
--     DEPENDS ON VIMWIKI PLUGIN
-------------------------------------------------------------------------------

vim.cmd[[command! -nargs=? VimwikiWeeklyReview :lua require('vimwiki_reviews').vimwiki_weekly_review(<f-args>)]]
vim.cmd[[command! -nargs=? VimwikiWeeklyTemplate :lua require('vimwiki_reviews').open_review_weekly_template(<f-args>)]]
vim.cmd[[command! -nargs=? VimwikiMonthlyReview :lua require('vimwiki_reviews').vimwiki_monthly_review(<f-args>)]]
vim.cmd[[command! -nargs=? VimwikiMonthlyTemplate :lua require('vimwiki_reviews').open_review_monthly_template(<f-args>)]]
vim.cmd[[command! -nargs=? VimwikiYearlyReview :lua require('vimwiki_reviews').vimwiki_yearly_review(<f-args>)]]
vim.cmd[[command! -nargs=? VimwikiYearlyTemplate :lua require('vimwiki_reviews').open_review_yearly_template(<f-args>)]]
vim.cmd[[command! -nargs=? VimwikiReviewIndex :lua require('vimwiki_reviews').vimwiki_review_index(<f-args>)]]

local default_opts = {noremap=true}
local function set_keymap(...) vim.api.nvim_set_keymap(...) end
set_keymap('n', '<Leader>wrw', '<cmd>VimwikiWeeklyReview<CR>', default_opts)
set_keymap('n', '<Leader>wrtw', '<cmd>VimwikiWeeklyTemplate<CR>', default_opts)
set_keymap('n', '<Leader>wrm', '<cmd>VimwikiMonthlyReview<CR>', default_opts)
set_keymap('n', '<Leader>wrtm', '<cmd>VimwikiMonthlyTemplate<CR>', default_opts)
set_keymap('n', '<Leader>wry', '<cmd>VimwikiYearlyReview<CR>', default_opts)
set_keymap('n', '<Leader>wrty', '<cmd>VimwikiYearlyTemplate<CR>', default_opts)
set_keymap('n', '<Leader>wri', '<cmd>VimwikiReviewIndex<CR>', default_opts)
