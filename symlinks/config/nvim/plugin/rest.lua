-------------------------------------------------------------------------------
--    - Vim REST Console setup and extra commands -
-------------------------------------------------------------------------------

local vim_rest_console_extensions = require("esensar.vim_rest_console_extensions")
vim.api.nvim_create_user_command(
	"ScratchRestConsole",
	vim_rest_console_extensions.open_scratch_rest_console,
	{ nargs = 0 }
)
vim.api.nvim_create_user_command("RestConsole", function(args)
	vim_rest_console_extensions.open_cached_rest_console(args.fargs)
end, { nargs = "?" })
vim.api.nvim_create_user_command("RestConsoleLocal", function(args)
	vim_rest_console_extensions.open_local_rest_console(args.fargs)
end, { nargs = "?" })
vim.api.nvim_create_user_command("RestConsoleCached", function(args)
	vim_rest_console_extensions.open_named_cached_rest_console(args.fargs[0] or args.fargs[1])
end, { nargs = 1 })
