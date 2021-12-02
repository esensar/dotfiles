-------------------------------------------------------------------------------
--    - JDTLS server configuration -
-------------------------------------------------------------------------------

local common_config = require("lsp.server_config")
local M = {}

function M.setup()
    require "jdtls".setup_dap()
    require "jdtls.setup".add_commands()
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        local default_opts = {noremap = true, silent = true}

        common_config.on_attach(client, bufnr)

        buf_set_keymap("n", "<A-CR>", "<cmd>lua require('jdtls').code_action()<CR>", default_opts)
        buf_set_keymap("n", "<Leader>ac", "<cmd>lua require('jdtls').code_action()<CR>", default_opts)
    end

    local root_markers = {"gradlew", "pom.xml"}
    local root_dir = require("jdtls.setup").find_root(root_markers)
    local home = os.getenv("HOME")

    local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = {
        flags = {
            allow_incremental_sync = true
        },
        on_attach = on_attach
    }
    config.settings = {
        java = {
            signatureHelp = {enabled = true},
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999
                }
            }
        }
    }
    config.cmd = {"jdtls-start.sh", workspace_folder}
    config.on_init = function(client, _)
        client.notify("workspace/didChangeConfiguration", {settings = config.settings})
    end

    local extendedClientCapabilities = require "jdtls".extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
        -- bundles = bundles;
        extendedClientCapabilities = extendedClientCapabilities
    }

    -- Server
    require("jdtls").start_or_attach(config)
end

return M
