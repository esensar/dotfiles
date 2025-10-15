-- Devcontainer setup
require("devcontainer").setup({
	autocommands = {
		clean = true,
		init = true,
		update = true,
	},
	attach_mounts = {
		neovim_config = {
			-- enables mounting local config to /root/.config/nvim in container
			enabled = true,
			-- makes mount readonly in container
			options = { "readonly" },
		},
		neovim_data = {
			-- enables mounting local data to /root/.local/share/nvim in container
			enabled = true,
			-- no options by default
			options = {},
		},
		-- Only useful if using neovim 0.8.0+
		neovim_state = {
			-- enables mounting local state to /root/.local/state/nvim in container
			enabled = true,
			-- no options by default
			options = {},
		},
	},
})
