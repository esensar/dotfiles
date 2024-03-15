-------------------------------------------------------------------------------
--    - JDTLS server configuration -
-------------------------------------------------------------------------------

local common_config = require("esensar.lsp.server_config")
local M = {}

local function is_in_config_home(bufname)
	bufname = bufname or vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	local dirname = vim.fn.fnamemodify(bufname, ":p:h")
	local getparent = function(p)
		return vim.fn.fnamemodify(p, ":h")
	end
	local config_path = vim.fn.resolve(vim.fn.expand(vim.fn.stdpath("config")))
	while getparent(dirname) ~= dirname do
		if dirname == config_path then
			return true
		else
			dirname = getparent(dirname)
		end
	end
	return false
end

function M.setup()
	local installed_jdtls = {
	}

	installed_jdtls.cmd = { "jdtls" }

	require("jdtls").setup_dap({ hotcoredeplace = "auto" })

	local config = vim.tbl_extend("force", installed_jdtls, {
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

	if is_in_config_home() then
		config.root_dir = vim.fn.resolve(vim.fn.expand(vim.fn.stdpath("config"))) .. "/rplugin/java"
		config.settings.java.project = {
			referencedLibraries = require("java_plugin_host").classpath,
		}
	end
	config.root_dir = require("jdtls.setup").find_root({ "gradlew", "pom.xml" })

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
