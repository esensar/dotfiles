-------------------------------------------------------------------------------
--    - LSP diagnostics config -
-------------------------------------------------------------------------------

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        -- Python
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.autopep8,

        -- Kotlin
        null_ls.builtins.formatting.ktlint,
        null_ls.builtins.diagnostics.ktlint,

        -- C++ and C
        null_ls.builtins.formatting.clang_format,

        -- Cmake
        null_ls.builtins.formatting.cmake_format,

        -- Lua
        null_ls.builtins.formatting.lua_format,

        -- Dart
        null_ls.builtins.formatting.dart_format,

        -- Go
        null_ls.builtins.formatting.gofmt,

        -- Rust
        null_ls.builtins.formatting.rustfmt,

        -- Java
        null_ls.builtins.formatting.google_java_format,

        -- General
        null_ls.builtins.formatting.trim_newlines,
        null_ls.builtins.formatting.trim_whitespace,
        null_ls.builtins.hover.dictionary,
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
            ]])
        end
    end
})

vim.keymap.set("n", "]w", vim.diagnostic.goto_next)
vim.keymap.set("n", "[w", vim.diagnostic.goto_prev)
vim.api.nvim_create_user_command("Warnings", vim.diagnostic.setloclist, {})
vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
