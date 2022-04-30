-------------------------------------------------------------------------------
--    - LSP diagnostics config -
-------------------------------------------------------------------------------

local null_ls = require("null-ls")
local custom_sources = require("esensar.lsp.null-ls_sources")
local common_config = require("esensar.lsp.server_config")

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
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.luacheck.with({
			extra_args = { "--config", vim.fn.stdpath("config") .. "/.luacheckrc" },
		}),

		-- Dart
		null_ls.builtins.formatting.dart_format,

		-- Go
		null_ls.builtins.formatting.gofmt,

		-- Rust
		null_ls.builtins.formatting.rustfmt,

		-- Zig
		null_ls.builtins.formatting.zigfmt,

		-- Java
		null_ls.builtins.formatting.google_java_format,

		-- General
		null_ls.builtins.formatting.trim_newlines,
		null_ls.builtins.formatting.trim_whitespace,
		null_ls.builtins.hover.dictionary,
		null_ls.builtins.code_actions.gitsigns,

		-- Godot
		custom_sources.formatters.gdformat,
		custom_sources.diagnostics.gdlint,
	},
	on_attach = common_config.on_attach,
})

vim.keymap.set("n", "]w", vim.diagnostic.goto_next)
vim.keymap.set("n", "[w", vim.diagnostic.goto_prev)
vim.api.nvim_create_user_command("Warnings", vim.diagnostic.setloclist, {})
vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
