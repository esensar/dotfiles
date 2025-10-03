-- Disable global default keymaps
for _, keymap in ipairs({ "grn", "gra", "grr", "gri", "gO" }) do
	vim.keymap.del("n", keymap)
end
vim.keymap.del("i", "<C-S>")

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<Leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
vim.keymap.set({ "n", "i" }, "<A-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<A-CR>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>ac", vim.lsp.buf.code_action)
vim.keymap.set("v", "<A-CR>", vim.lsp.buf.code_action)
vim.keymap.set("v", "<Leader>ac", vim.lsp.buf.code_action)
