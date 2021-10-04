-------------------------------------------------------------------------------
--    - Vim REST Console setup and extra commands -
-------------------------------------------------------------------------------

vim.cmd[[command! -nargs=0 ScratchRestConsole :lua require('vim_rest_console_extensions').open_scratch_rest_console()]]
vim.cmd[[command! -nargs=1 RestConsole :lua require('vim_rest_console_extensions').open_cached_rest_console(<f-args>)]]
vim.cmd[[command! -nargs=1 RestConsoleLocal :lua require('vim_rest_console_extensions').open_local_rest_console(<f-args>)]]
vim.cmd[[command! -nargs=1 RestConsoleCached :lua require('vim_rest_console_extensions').open_cached_rest_console(<f-args>)]]
