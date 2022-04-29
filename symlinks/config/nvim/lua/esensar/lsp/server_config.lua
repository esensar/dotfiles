-------------------------------------------------------------------------------
--    - LSP servers common config -
-------------------------------------------------------------------------------

local M = {}

M.on_attach = function(_, bufnr)
	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Lsp keymaps
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<A-CR>", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<Leader>ac", vim.lsp.buf.code_action, opts)
end

return M
