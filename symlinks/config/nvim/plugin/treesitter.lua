require("nvim-treesitter").setup({
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath("data") .. "/site",
})
require("nvim-treesitter").install({ "c", "cpp", "rust", "javascript", "zig" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "rust", "javascript", "zig" },
	callback = function()
		-- syntax highlighting, provided by Neovim
		vim.treesitter.start()
		-- indentation, provided by nvim-treesitter
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
