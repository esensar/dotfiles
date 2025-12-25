vim.api.nvim_create_user_command("Haredoc", function(cmd)
	vim.api.nvim_command("Dispatch haredoc " .. cmd.args)
end, { nargs = "+", desc = "Run haredoc" })
