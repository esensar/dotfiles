-------------------------------------------------------------------------------
--    - NeoVim DAP (Debug Adapter Protocol) config -
-------------------------------------------------------------------------------

local dap = require("dap")
local dap_install = require("dap-install")

local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
    dap_install.config(debugger)
end

vim.cmd [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]

-- Nvim DAP Treesitter integration
require("nvim-dap-virtual-text").setup()

-- Keymaps
local function set_keymap(...)
    vim.api.nvim_set_keymap(...)
end

local default_opts = {noremap = true, silent = true}
set_keymap("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", default_opts)
set_keymap("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", default_opts)
set_keymap("n", "<Leader>dso", "<cmd>lua require'dap'.step_over()<CR>", default_opts)
set_keymap("n", "<Leader>dsi", "<cmd>lua require'dap'.step_into()<CR>", default_opts)
set_keymap("n", "<Leader>dro", "<cmd>lua require'dap'.open()<CR>", default_opts)

-- Nvim DAP UI
require("dapui").setup()

-- Debugger Hover map
local api = vim.api
local keymap_restore = {}
dap.listeners.after["event_initialized"]["me"] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, "n")
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, "n", "K")
            end
        end
    end
    api.nvim_set_keymap("n", "K", '<Cmd>lua require("dap.ui.variables").hover()<CR>', {silent = true})
end

dap.listeners.after["event_terminated"]["me"] = function()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, {silent = keymap.silent == 1})
    end
    keymap_restore = {}
end
