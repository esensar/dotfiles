-- Vim configuration utility commands

local function edit_vim_config()
	vim.cmd("edit $VIMHOME/init.lua")
end

local function edit_vim_plugins()
	vim.cmd("edit $VIMPLUGINS")
end

local function reload_vim_config()
	require("plenary.reload").reload_module("esensar", true)
	vim.cmd("source $MYVIMRC")
end

vim.api.nvim_create_user_command(
	"EditVimConfig",
	edit_vim_config,
	{ desc = "Edit vim configuration ($MYVIMRC - init.lua)" }
)
vim.api.nvim_create_user_command("EditVimPlugins", edit_vim_plugins, { desc = "Edit plugin list file" })
vim.api.nvim_create_user_command("ReloadVimConfig", reload_vim_config, { desc = "Reload init.lua and all lua files" })

vim.keymap.set("n", "<Leader>vec", edit_vim_config)
vim.keymap.set("n", "<Leader>vep", edit_vim_plugins)
vim.keymap.set("n", "<Leader>vcr", reload_vim_config)
