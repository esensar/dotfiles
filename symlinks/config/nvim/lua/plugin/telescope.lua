-------------------------------------------------------------------------------
--    - Telescope configuration -
-------------------------------------------------------------------------------

require('telescope').setup{
}

require('telescope').load_extension('dap')

default_opts = {noremap = true}

local function set_keymap(...) vim.api.nvim_set_keymap(...) end
set_keymap('n', '<C-P>', "<cmd>lua require('telescope.builtin').find_files()<CR>", default_opts)
set_keymap('n', '<C-M-F>', "<cmd>lua require('telescope.builtin').live_grep()<CR>", default_opts)
