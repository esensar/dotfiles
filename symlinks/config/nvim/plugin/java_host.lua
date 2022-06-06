-- Configuration for Java remote plugin host
require("java_plugin_host").setup({
	autostart = false,
	rplugins = {
		load_class = true,
		compile_java = true,
	},
	common_host = {
		custom_repositories = {
			"https://maven.pkg.github.com/OWNER/REPOSITORY",
		},
	},
})
