-------------------------------------------------------------------------------
--    - NeoVim DAP (Debug Adapter Protocol) config -
-------------------------------------------------------------------------------

local dap = require("dap")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "dap-repl",
	callback = function(_)
		require("dap.ext.autocompl").attach()
	end,
})

-- Nvim DAP Treesitter integration
require("nvim-dap-virtual-text").setup()

-- Keymaps
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dsi", dap.step_into)

-- Neovim Lua debugging
vim.api.nvim_create_user_command("NeovimDebugStart", function()
	require("osv").launch()
end, { desc = "Start debugging neovim" })
vim.api.nvim_create_user_command("NeovimDebugThis", function()
	require("osv").run_this()
end, { desc = "Start debugging this neovim lua script" })

-- Vscode launch.json support
vim.api.nvim_create_user_command("DapLoadVsCodeLaunch", function(args)
	require("dap.ext.vscode").load_launchjs(args.args)
end, { desc = "Load VsCode launch.json for DAP" })

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
				vim.keymap.del("n", "K", { buffer = buf })
			end
		end
	end
	vim.keymap.set({ "n", "v" }, "K", function()
		dapui.eval()
	end)
end

dap.listeners.after["event_terminated"]["me"] = function()
	for _, keymap in pairs(keymap_restore) do
		vim.keymap.set(
			keymap.mode,
			keymap.lhs,
			keymap.callback or keymap.rhs,
			{ silent = keymap.silent == 1, buffer = keymap.buffer }
		)
	end
	keymap_restore = {}
end

-- dap utils
local function executable_input()
	return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

local function args_input()
	return vim.split(vim.fn.input("Args: "), " ")
end

-- Additional servers
dap.adapters.lldb = {
	type = "executable",
	command = "lldb-vscode",
	name = "lldb",
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host, port = config.port })
end

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = executable_input,
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
		postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
	},
	{
		name = "Launch with args",
		type = "lldb",
		request = "launch",
		program = executable_input,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = args_input,
		runInTerminal = false,
		postRunCommands = { "process handle -p true -s false -n false SIGWINCH" },
	},
	{
		name = "Attach to process",
		type = "lldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
	},
	{
		name = "Attach to PID",
		type = "lldb",
		request = "attach",
		pid = function()
			return tonumber(vim.fn.input("PID: "))
		end,
		args = {},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.configurations.zig = dap.configurations.cpp

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
		host = function()
			local value = vim.fn.input("Host [127.0.0.1]: ")
			if value ~= "" then
				return value
			end
			return "127.0.0.1"
		end,
		port = function()
			local val = tonumber(vim.fn.input("Port: "))
			assert(val, "Please provide a port number")
			return val
		end,
	},
}

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
