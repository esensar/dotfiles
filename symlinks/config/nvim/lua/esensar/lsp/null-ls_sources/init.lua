-- Place for custom null-ls sources
return {
	formatters = {
		gdformat = require("esensar.lsp.null-ls_sources.gdformat"),
	},
	diagnostics = {
		gdlint = require("esensar.lsp.null-ls_sources.gdlint"),
	},
}
