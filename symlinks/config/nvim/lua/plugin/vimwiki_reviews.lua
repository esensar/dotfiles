-------------------------------------------------------------------------------
--    - Vimwiki extensions for working with weekly/monthly/yearly reviews -
--
--     DEPENDS ON VIMWIKI PLUGIN
-------------------------------------------------------------------------------

vim.cmd[[command! -count=0 VimwikiWeeklyReview :lua require('vimwiki_reviews').vimwiki_weekly_review(<count>)]]
vim.cmd[[command! -count=0 VimwikiWeeklyTemplate :lua require('vimwiki_reviews').open_review_weekly_template(<count>)]]
vim.cmd[[command! -count=0 VimwikiMonthlyReview :lua require('vimwiki_reviews').vimwiki_monthly_review(<count>)]]
vim.cmd[[command! -count=0 VimwikiMonthlyTemplate :lua require('vimwiki_reviews').open_review_monthly_template(<count>)]]
vim.cmd[[command! -count=0 VimwikiYearlyReview :lua require('vimwiki_reviews').vimwiki_yearly_review(<count>)]]
vim.cmd[[command! -count=0 VimwikiYearlyTemplate :lua require('vimwiki_reviews').open_review_yearly_template(<count>)]]
vim.cmd[[command! -count=0 VimwikiReviewIndex :lua require('vimwiki_reviews').vimwiki_review_index(<count>)]]

local default_opts = {noremap=true}
local function set_keymap(...) vim.api.nvim_set_keymap(...) end
set_keymap('n', '<Leader>wrw', "<Cmd>lua require('vimwiki_reviews').vimwiki_weekly_review(vim.v.count)<CR>", default_opts)
set_keymap('n', '<Leader>wrtw', "<Cmd>lua require('vimwiki_reviews').open_review_weekly_template(vim.v.count)<CR>", default_opts)
set_keymap('n', '<Leader>wrm', "<Cmd>lua require('vimwiki_reviews').vimwiki_monthly_review(vim.v.count)<CR>", default_opts)
set_keymap('n', '<Leader>wrtm', "<Cmd>lua require('vimwiki_reviews').open_review_monthly_template(vim.v.count)<CR>", default_opts)
set_keymap('n', '<Leader>wry', "<Cmd>lua require('vimwiki_reviews').vimwiki_yearly_review(vim.v.count)<CR>", default_opts)
set_keymap('n', '<Leader>wrty', "<Cmd>lua require('vimwiki_reviews').open_review_yearly_template(vim.v.count)<CR>", default_opts)
set_keymap('n', '<Leader>wri', "<Cmd>lua require('vimwiki_reviews').vimwiki_review_index(vim.v.count)<CR>", default_opts)
