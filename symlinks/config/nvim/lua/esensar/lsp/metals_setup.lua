-------------------------------------------------------------------------------
--    - Metals server configuration -
-------------------------------------------------------------------------------

local common_config = require("esensar.lsp.server_config")
local M = {}

local metals_config = require("metals").bare_config()
metals_config.on_attach = common_config.on_attach

function M.setup()
	require("metals").initialize_or_attach(metals_config)
end

return M
