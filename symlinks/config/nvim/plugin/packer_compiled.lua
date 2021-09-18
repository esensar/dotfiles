-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/ensar/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/ensar/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/ensar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/ensar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ensar/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ale = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["direnv.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/direnv.vim"
  },
  ["flutter-tools.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nlua.nvim"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspupdate"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-lspupdate"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["phoenix.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/phoenix.vim"
  },
  playground = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  tabular = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  ["utl.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/utl.vim"
  },
  ["vim-colorschemes"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-colorschemes"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dadbod"
  },
  ["vim-dadbod-ui"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dadbod-ui"
  },
  ["vim-devdocs"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-devdocs"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim"
  },
  ["vim-docile"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-docile"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-fireplace"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-fireplace"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-godot"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-godot"
  },
  ["vim-grepper"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-grepper"
  },
  ["vim-ledger"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-ledger"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-obsession"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-qf"
  },
  ["vim-rails"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-rails"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-salve"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-salve"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sensible"
  },
  ["vim-sexp"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sexp"
  },
  ["vim-sexp-mappings-for-regular-people"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sexp-mappings-for-regular-people"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-vinegar"
  },
  vimwiki = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["vimwiki-reviews-lua"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vimwiki-reviews-lua"
  }
}

time([[Defining packer_plugins]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
