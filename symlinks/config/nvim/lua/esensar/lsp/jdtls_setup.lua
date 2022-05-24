-------------------------------------------------------------------------------
--    - JDTLS server configuration -
-------------------------------------------------------------------------------

local common_config = require("esensar.lsp.server_config")
local M = {}

function M.setup()
	local _, installed_jdtls = require("nvim-lsp-installer.servers").get_server("jdtls")

	require("jdtls").setup_dap({ hotcoredeplace = "auto" })
	require("jdtls.setup").add_commands()

	local root_markers = { "gradlew", "pom.xml" }
	local root_dir = require("jdtls.setup").find_root(root_markers)

	local config = vim.tbl_extend("force", installed_jdtls["_default_options"], {
		flags = {
			allow_incremental_sync = true,
		},
		on_attach = common_config.on_attach,
	})
	config.settings = {
		java = {
			signatureHelp = { enabled = true },
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
		},
	}
	config.root_dir = root_dir
	config.on_init = function(client, _)
		client.notify("workspace/didChangeConfiguration", { settings = config.settings })
	end

	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
	config.init_options = {
		-- bundles = bundles;
		extendedClientCapabilities = extendedClientCapabilities,
	}

	-- Server
	require("jdtls").start_or_attach(config)
end

return M
