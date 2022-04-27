-------------------------------------------------------------------------------
--    - Telescope configuration -
-------------------------------------------------------------------------------

local actions = require("telescope.actions")
require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                -- Switch out M-q and C-q since C-q will be used more often
                ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
            },
            n = {
                -- Switch out M-q and C-q since C-q will be used more often
                ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
            }
        }
    }
}

require("telescope").load_extension("dap")

vim.keymap.set(
    "n",
    "<C-P>",
    function()
        require("telescope.builtin").find_files()
    end
)
vim.keymap.set(
    "n",
    "<C-M-F>",
    function()
        require("telescope.builtin").live_grep()
    end
)
