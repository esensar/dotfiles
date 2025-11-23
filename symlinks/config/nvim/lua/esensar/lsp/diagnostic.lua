-------------------------------------------------------------------------------
--    - LSP diagnostics config -
-------------------------------------------------------------------------------

if not vim.g.disable_formatting then
	require("conform").setup({
		formatters_by_ft = {
			python = { "isort", "autopep8" },
			kotlin = { "ktlint", "detekt" },
			cpp = { "clang-format" },
			c = { "clang-format" },
			cmake = { "cmake_format" },
			lua = { "stylua" },
			dart = { "dart_format" },
			go = { "gofmt" },
			rust = { "rustfmt" },
			zig = { "zigfmt" },
			java = { "clang-format" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			godot = { "gdformat" },
			xml = { "xmlformatter", "xmllint" },
			["*"] = { "trim_whitespace", "trim_newlines" },
		},
		lsp_format = "fallback",
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
	typescript = { "eslint_d" },
	javascript = { "eslint_d" },
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
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format()
end, { desc = "Format current buffer using LSP" })

-- Auto linting
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		if not vim.g.disable_formatting then
			require("conform").format({ bufnr = args.buf })
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
		require("lint").try_lint({ "codespell" })
		require("lint").try_lint({ "misspell" })
	end,
})

vim.diagnostic.config({ virtual_text = true })
