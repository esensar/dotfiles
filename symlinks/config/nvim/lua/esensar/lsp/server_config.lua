-------------------------------------------------------------------------------
--    - LSP servers common config -
-------------------------------------------------------------------------------

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
	-- Lsp keymaps
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	-- Optional config
	if client.server_capabilities.completionProvider then
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	end

	if client.server_capabilities.definitionProvider then
		vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
		vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
	end

	if client.server_capabilities.documentFormattingProvider then
		local au_id = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = au_id })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = au_id,
			callback = function()
				vim.lsp.buf.format()
			end,
			buffer = bufnr,
		})
	end

	if vim.fn.has("nvim-0.10") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

return {
	on_attach = on_attach,
	capabilities = capabilities,
}
