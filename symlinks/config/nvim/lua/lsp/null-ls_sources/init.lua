-- Place for custom null-ls sources
return {
	formatters = {
		gdformat = require("lsp.null-ls_sources.gdformat"),
	},
	diagnostics = {
		gdlint = require("lsp.null-ls_sources.gdlint"),
	},
}
