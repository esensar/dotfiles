-------------------------------------------------------------------------------
--    - Local vimrc commands -
-------------------------------------------------------------------------------

vim.api.nvim_create_user_command("EditLocalVimrc", function(_)
	require("esensar.direnv_vimrc_local").open_local_vimrc()
end, { nargs = 0 })
