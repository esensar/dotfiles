-------------------------------------------------------------------------------
--    - LSP servers common config -
-------------------------------------------------------------------------------

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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

	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
			augroup LspFormatting
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
			augroup END
			]])
	end
end

return {
	on_attach = on_attach,
	capabilities = capabilities,
}
