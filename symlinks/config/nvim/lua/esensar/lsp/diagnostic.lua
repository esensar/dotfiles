-------------------------------------------------------------------------------
--    - LSP diagnostics config -
-------------------------------------------------------------------------------

if not vim.g.disable_formatting then
	require("formatter").setup({
		filetype = {
			python = {
				require("formatter.filetypes.python").isort,
				require("formatter.filetypes.python").autopep8,
			},
			kotlin = {
				require("formatter.filetypes.kotlin").ktlint,
				require("formatter.filetypes.kotlin").detekt,
			},
			cpp = {
				require("formatter.filetypes.cpp").clangformat,
			},
			c = {
				require("formatter.filetypes.c").clangformat,
			},
			cmake = {
				require("formatter.filetypes.cmake").cmakeformat,
			},
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
			dart = {
				require("formatter.filetypes.dart").dartformat,
			},
			go = {
				require("formatter.filetypes.go").gofmt,
			},
			rust = {
				require("formatter.filetypes.rust").rustfmt,
			},
			zig = {
				require("formatter.filetypes.zig").zigfmt,
			},
			java = {
				require("esensar.lsp.formatters.clang-format-java"),
			},
			godot = {
				require("esensar.lsp.formatters.gdformat"),
			},
			xml = {
				require("formatter.filetypes.xml").xmlformat,
				require("formatter.filetypes.xml").xmllint,
			},
			["*"] = {
				require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		},
	})
end

require("lint").linters_by_ft = {
	python = { "flake8" },
	kotlin = { "ktlint" },
	clojure = { "clj_kondo" },
	c = { "clangtidy" },
	cpp = { "clangtidy" },
	lua = { "luacheck" },
	gdscript = { "gdlint" },
}

local codespell_config = require("lint").linters.codespell
table.insert(codespell_config.args, 0, "crate")
table.insert(codespell_config.args, 0, "-L")

require("lint").linters.misspell = {
	name = "Misspell",
	stdin = true,
	cmd = "misspell",
	parser = require("lint.parser").from_pattern("(%w+):(%d+):(%d+):(.+)", { "file", "lnum", "col", "message" }),
}

require("lint").linters.gdlint = {
	name = "GDLint",
	cmd = "gdlint",
	stdin = true,
	args = {
		function()
			vim.fn.expand("%")
		end,
	},
	stream = "stderr",
	parser = require("lint.parser").from_pattern("(.+):(%d+): Error: (.*)", { "file", "lnum", "message" }),
}

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
vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, { desc = "Format current buffer using LSP" })

-- Auto linting
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		if not vim.g.disable_formatting then
			vim.cmd("FormatWrite")
		end
		require("lint").try_lint()
		require("lint").try_lint({ "codespell" })
		require("lint").try_lint({ "misspell" })
	end,
})
