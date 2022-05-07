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

vim.api.nvim_create_user_command("PlenaryTestFile", function()
	require("plenary.test_harness").test_directory(vim.fn.expand("%:p"))
end, {})

vim.api.nvim_create_user_command("PlenaryTestFileWithLocalMinInit", function()
	require("plenary.test_harness").test_directory(vim.fn.expand("%:p"), { minimal_init = "tests/minimal.vim" })
end, {})
