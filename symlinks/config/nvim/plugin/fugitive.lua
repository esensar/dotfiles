-------------------------------------------------------------------------------
--    - Fugitive.vim setup and extra commands -
-------------------------------------------------------------------------------

vim.cmd([[command! -nargs=0 Ggpush :lua require('esensar.fugitive_extensions').push_origin()]])
vim.cmd([[command! -nargs=0 Ggpull :lua require('esensar.fugitive_extensions').pull_origin()]])
vim.cmd([[command! -nargs=? Gpropen :lua require('esensar.fugitive_extensions').open_new_pr(<f-args>)]])
vim.cmd([[command! -nargs=? Gpr Gpropen <args>]])
vim.cmd([[command! -nargs=? Gprprint :lua require('esensar.fugitive_extensions').print_pr_url(<f-args>)]])
vim.cmd([[command! -nargs=? Gprcopy :lua require('esensar.fugitive_extensions').copy_pr_url(<f-args>)]])
vim.cmd([[command! -nargs=1 Gcbranch :lua require('esensar.fugitive_extensions').create_branch(<f-args>)]])
vim.cmd([[command! -nargs=0 Gcmaster :lua require('esensar.fugitive_extensions').checkout_branch('main')]])
vim.cmd([[command! -nargs=0 Gcm Gcmaster]])
vim.cmd([[command! -nargs=0 Gcdev :lua require('esensar.fugitive_extensions').checkout_branch('develop')]])
vim.cmd([[command! -nargs=1 Gcheckout :lua require('esensar.fugitive_extensions').checkout_branch(<f-args>)]])
vim.cmd([[command! -nargs=1 Gc Gcheckout <args>]])
