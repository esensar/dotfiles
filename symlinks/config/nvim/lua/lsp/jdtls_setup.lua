-------------------------------------------------------------------------------
--    - JDTLS server configuration -
-------------------------------------------------------------------------------

local common_config = require("lsp.server_config")
local M = {}

function M.setup()
	require'jdtls.setup'.add_commands()
  require'jdtls'.setup_dap()
	local on_attach = function(client, bufnr)

		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
		local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

		buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

		local default_opts = {noremap = true, silent = true}

		common_config.on_attach(client, bufnr)

		buf_set_keymap('n', '<A-CR>', "<cmd>lua require('jdtls').code_action()<CR>", default_opts)
		buf_set_keymap('n', '<Leader>ac', "<cmd>lua require('jdtls').code_action()<CR>", default_opts)
	end

	local root_markers = {'gradlew', 'pom.xml'}
	local root_dir = require('jdtls.setup').find_root(root_markers)
	local home = os.getenv('HOME')

	local capabilities = {
		workspace = {
			configuration = true
		},
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true
				}
			}
		}
	}

	local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
	local config = {
		flags = {
			allow_incremental_sync = true,
		};
		capabilities = capabilities,
		on_attach = on_attach,
	}
	config.settings = {
		java = {
			signatureHelp = { enabled = true };
			sources = {
				organizeImports = {
					starThreshold = 9999;
					staticStarThreshold = 9999;
				};
			};
		};
	}
	config.cmd = {'jdtls-start.sh', workspace_folder}
	config.on_init = function(client, _)
		client.notify('workspace/didChangeConfiguration', { settings = config.settings })
	end

	local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
      -- bundles = bundles;
      extendedClientCapabilities = extendedClientCapabilities;
    }

    -- UI
    local finders = require'telescope.finders'
    local sorters = require'telescope.sorters'
    local actions = require'telescope.actions'
    local pickers = require'telescope.pickers'
    require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
      local opts = {}
      pickers.new(opts, {
        prompt_title = prompt,
        finder    = finders.new_table {
          results = items,
          entry_maker = function(entry)
            return {
              value = entry,
              display = label_fn(entry),
              ordinal = label_fn(entry),
            }
          end,
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            local selection = actions.get_selected_entry(prompt_bufnr)
            actions.close(prompt_bufnr)

            cb(selection.value)
          end)

          return true
        end,
      }):find()
    end

    -- Server
    require('jdtls').start_or_attach(config)
end

return M
