-------------------------------------------------------------------------------
--    - Vim-test and general testing config -
-------------------------------------------------------------------------------

local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-rust"),
		require("neotest-plenary"),
		require("neotest-vim-test")({
			ignore_file_types = { "rust", "lua" },
		}),
	},
})

local last = nil

-- Map test running commands
local opts = { silent = true }
vim.keymap.set("n", "<Leader>tn", function()
	last = nil
	neotest.run.run()
end, opts)
vim.keymap.set("n", "<Leader>tdn", function()
	last = { strategy = "dap", suite = false }
	neotest.run.run(last)
end, opts)
vim.keymap.set("n", "<Leader>tf", function()
	last = vim.fn.expand("%")
	neotest.run.run(last)
end, opts)
vim.keymap.set("n", "<Leader>tdf", function()
	last = { vim.fn.expand("%"), strategy = "dap", suite = false }
	neotest.run.run(last)
end, opts)
vim.keymap.set("n", "<Leader>ts", function()
	last = { suite = true }
	neotest.run.run(last)
end, opts)
vim.keymap.set("n", "<Leader>tds", function()
	last = { strategy = "dap", suite = true }
	neotest.run.run(last)
end, opts)
vim.keymap.set("n", "<Leader>tl", function()
	if last then
		neotest.run.run(last)
	else
		neotest.run.run()
	end
end, opts)
