local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

return {
	name = "gdlint",
	meta = {
		url = "https://github.com/Scony/godot-gdscript-toolkit",
		description = "Linter for GDScript",
	},
	method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	filetypes = { "gdscript" },
	generator = helpers.generator_factory({
		command = "gdlint",
		args = { "$FILENAME" },
		format = "line",
		from_stderr = true,
		multiple_files = true,
		check_exit_code = function(code)
			return code == 0
		end,
		on_output = helpers.diagnostics.from_patterns({
			{
				pattern = "(.+):(%d+): Error: (.*)",
				groups = { "filename", "row", "message" },
				overrides = {
					diagnostic = {
						severity = helpers.diagnostics.severities.error,
					},
				},
			},
		}),
	}),
}
