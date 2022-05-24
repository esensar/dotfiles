-------------------------------------------------------------------------------
--    - JDTLS server configuration -
-------------------------------------------------------------------------------

local common_config = require("esensar.lsp.server_config")
local M = {}

function M.setup()
	require("jdtls").setup_dap()
	require("jdtls.setup").add_commands()
	local on_attach = function(client, bufnr)
		common_config.on_attach(client, bufnr)

		local opts = { buffer = bufnr }
		local code_action_fun = function()
			require("jdtls").code_action()
		end
		vim.keymap.set("n", "<A-CR>", code_action_fun, opts)
		vim.keymap.set("n", "<Leader>ac", code_action_fun, opts)
	end

	local root_markers = { "gradlew", "pom.xml" }
	local root_dir = require("jdtls.setup").find_root(root_markers)

	local config = {
		flags = {
			allow_incremental_sync = true,
		},
		on_attach = on_attach,
	}
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
	config.cmd = { "jdtls" }
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
