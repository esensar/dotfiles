-------------------------------------------------------------------------------
--    - Telescope configuration -
-------------------------------------------------------------------------------

local actions = require('telescope.actions')
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				-- Switch out M-q and C-q since C-q will be used more often
				["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
			n = {
				-- Switch out M-q and C-q since C-q will be used more often
				["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			}
		},
	}
}

require('telescope').load_extension('dap')

default_opts = {noremap = true}

local function set_keymap(...) vim.api.nvim_set_keymap(...) end
set_keymap('n', '<C-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", default_opts)
set_keymap('n', '<C-M-F>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", default_opts)
