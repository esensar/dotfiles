-------------------------------------------------------------------------------
--    - LSP diagnostics config -
-------------------------------------------------------------------------------

require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = false,
        virtual_text = false,
        signs = true,
        update_in_insert = false
    }
)

vim.g.diagnostic_enable_virtual_text = 1
