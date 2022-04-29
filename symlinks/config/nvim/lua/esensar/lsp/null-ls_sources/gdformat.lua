local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

return {
	name = "gdformat",
	meta = {
		url = "https://github.com/Scony/godot-gdscript-toolkit",
		description = "Formatter for GDScript",
	},
	method = null_ls.methods.FORMATTING,
	filetypes = { "gdscript" },
	generator = helpers.formatter_factory({
		command = "gdformat",
		args = { "--diff", "-" },
		to_stdin = true,
	}),
}
