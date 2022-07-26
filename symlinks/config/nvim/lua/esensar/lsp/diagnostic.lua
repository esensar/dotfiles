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
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { "cpp", "c" },
		}),

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
		null_ls.builtins.hover.dictionary.with({
			filetypes = { "text", "markdown", "vimwiki" },
		}),
		null_ls.builtins.diagnostics.misspell,
		null_ls.builtins.completion.spell,
		null_ls.builtins.code_actions.gitsigns,

		-- Godot
		custom_sources.formatters.gdformat,
		custom_sources.diagnostics.gdlint,

		-- Vim-Ledger
		custom_sources.completion.ledger,
	},
	on_attach = common_config.on_attach,
})

vim.keymap.set("n", "]w", vim.diagnostic.goto_next)
vim.keymap.set("n", "[w", vim.diagnostic.goto_prev)
vim.api.nvim_create_user_command(
	"Warnings",
	vim.diagnostic.setqflist,
	{ desc = "Show all LSP project warning in a quickfix list" }
)
vim.api.nvim_create_user_command(
	"WarningsLoc",
	vim.diagnostic.setloclist,
	{ desc = "Show LSP buffer warnings in a location list" }
)
vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, { desc = "Format current buffer using LSP" })
