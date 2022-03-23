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
local dapui = require("dapui")
dapui.setup()

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

-- Additional servers
dap.adapters.lldb = {
    type = "executable",
    command = "lldb-vscode",
    name = "lldb"
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

        runInTerminal = false,
        -- 💀
        -- If you use `runInTerminal = true` and resize the terminal window,
        -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
        -- To avoid that uncomment the following option
        -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
        postRunCommands = {"process handle -p true -s false -n false SIGWINCH"}
    }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
