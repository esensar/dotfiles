-------------------------------------------------------------------------------
--    - LSP servers common config -
-------------------------------------------------------------------------------

local M = {}

M.on_attach = function(client, bufnr)
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Lsp keymaps
    local opts = {buffer = bufnr}
    vim.keymap.set(
        "n",
        "<C-]>",
        function()
            vim.lsp.buf.definition()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "gD",
        function()
            vim.lsp.buf.declaration()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "gr",
        function()
            vim.lsp.buf.references()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "gi",
        function()
            vim.lsp.buf.implementation()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "<Leader>rn",
        function()
            vim.lsp.buf.rename()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "<C-k>",
        function()
            vim.lsp.buf.signature_help()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "K",
        function()
            vim.lsp.buf.hover()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "<A-CR>",
        function()
            vim.lsp.buf.code_action()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "<Leader>ac",
        function()
            vim.lsp.buf.code_action()
        end,
        opts
    )
    vim.keymap.set(
        "n",
        "<Leader>a",
        function()
            vim.lsp.buf.code_action_range()
        end,
        opts
    )
end

return M
