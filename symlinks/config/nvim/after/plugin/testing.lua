-------------------------------------------------------------------------------
--    - Vim-test and general testing config -
-------------------------------------------------------------------------------

-- make test commands execute using dispatch.vim
vim.g["test#strategy"] = "dispatch"
vim.g["test#csharp#runner"] = "dotnettest"

-- Map test running commands
local opts = { silent = true }
vim.keymap.set("n", "<Leader>tn", ":TestNearest<CR>", opts)
vim.keymap.set("n", "<Leader>tf", ":TestFile<CR>", opts)
vim.keymap.set("n", "<Leader>ts", ":TestSuite<CR>", opts)
vim.keymap.set("n", "<Leader>tl", ":TestLast<CR>", opts)
vim.keymap.set("n", "<Leader>tg", ":TestVisit<CR>", opts)

local last_path = nil

vim.api.nvim_create_user_command("PlenaryTestFile", function()
	last_path = vim.fn.expand("%:p")

	require("plenary.test_harness").test_directory(last_path)
end, {})

vim.api.nvim_create_user_command("PlenaryTestSuite", function()
	last_path = vim.fn["projectionist#path"]()

	require("plenary.test_harness").test_directory(last_path)
end, {})

vim.api.nvim_create_user_command("PlenaryTestLast", function()
	if not last_path then
		vim.notify("No plenary tests run yet! Nothing to do here", vim.log.levels.WARN)
		return
	end
	require("plenary.test_harness").test_directory(last_path)
end, {})

vim.api.nvim_create_user_command("PlenaryVisitLastTest", function()
	if not last_path then
		vim.notify("No plenary tests run yet! Nothing to do here", vim.log.levels.WARN)
		return
	end
	vim.cmd("edit " .. last_path)
end, {})

local au_id = vim.api.nvim_create_augroup("plenary_test_group", {})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	group = au_id,
	callback = function()
		local local_opts = { silent = true, buffer = true }
		vim.keymap.set("n", "<Leader>tn", ":PlenaryTestFile<CR>", local_opts)
		vim.keymap.set("n", "<Leader>tf", ":PlenaryTestFile<CR>", local_opts)
		vim.keymap.set("n", "<Leader>ts", ":PlenaryTestSuite<CR>", local_opts)
		vim.keymap.set("n", "<Leader>tl", ":PlenaryTestLast<CR>", local_opts)
		vim.keymap.set("n", "<Leader>tg", ":PlenaryVisitLastTest<CR>", local_opts)
	end,
})
