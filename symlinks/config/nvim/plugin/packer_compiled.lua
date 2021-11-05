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
  ["DAPInstall.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/DAPInstall.nvim",
    url = "https://github.com/Pocco81/DAPInstall.nvim"
  },
  ale = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/ale",
    url = "https://github.com/dense-analysis/ale"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/astronauta.nvim",
    url = "https://github.com/tjdevries/astronauta.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["direnv.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/direnv.vim",
    url = "https://github.com/direnv/direnv.vim"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/editorconfig.nvim",
    url = "https://github.com/gpanders/editorconfig.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["flutter-tools.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim",
    url = "https://github.com/akinsho/flutter-tools.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nlua.nvim",
    url = "https://github.com/tjdevries/nlua.nvim"
  },
  ["nvim-ale-diagnostic"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-ale-diagnostic",
    url = "https://github.com/nathunsmitty/nvim-ale-diagnostic"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-lspupdate"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-lspupdate",
    url = "https://github.com/alexaandru/nvim-lspupdate"
  },
  ["nvim-remote-containers"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-remote-containers",
    url = "https://github.com/jamestthompson3/nvim-remote-containers"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["phoenix.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/phoenix.vim",
    url = "https://github.com/c-brenn/phoenix.vim"
  },
  playground = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  tabular = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["utl.vim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/utl.vim",
    url = "https://github.com/vim-scripts/utl.vim"
  },
  ["vim-colorschemes"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-colorschemes",
    url = "https://github.com/flazz/vim-colorschemes"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dadbod",
    url = "https://github.com/tpope/vim-dadbod"
  },
  ["vim-dadbod-ui"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dadbod-ui",
    url = "https://github.com/kristijanhusak/vim-dadbod-ui"
  },
  ["vim-devdocs"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-devdocs",
    url = "https://github.com/romainl/vim-devdocs"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim",
    url = "https://github.com/radenling/vim-dispatch-neovim"
  },
  ["vim-docile"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-docile",
    url = "https://github.com/tandrewnichols/vim-docile"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-endwise",
    url = "https://github.com/tpope/vim-endwise"
  },
  ["vim-fireplace"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-fireplace",
    url = "https://github.com/tpope/vim-fireplace"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-godot"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-godot",
    url = "https://github.com/habamax/vim-godot"
  },
  ["vim-grepper"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-grepper",
    url = "https://github.com/mhinz/vim-grepper"
  },
  ["vim-ledger"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-ledger",
    url = "https://github.com/ledger/vim-ledger"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-obsession",
    url = "https://github.com/tpope/vim-obsession"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-rails"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-rails",
    url = "https://github.com/tpope/vim-rails"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rest-console"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-rest-console",
    url = "https://github.com/diepm/vim-rest-console"
  },
  ["vim-salve"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-salve",
    url = "https://github.com/tpope/vim-salve"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sensible",
    url = "https://github.com/tpope/vim-sensible"
  },
  ["vim-sexp"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sexp",
    url = "https://github.com/guns/vim-sexp"
  },
  ["vim-sexp-mappings-for-regular-people"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sexp-mappings-for-regular-people",
    url = "https://github.com/tpope/vim-sexp-mappings-for-regular-people"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-speeddating",
    url = "https://github.com/tpope/vim-speeddating"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-tridactyl"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-tridactyl",
    url = "https://github.com/tridactyl/vim-tridactyl"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vim-vinegar",
    url = "https://github.com/tpope/vim-vinegar"
  },
  vimwiki = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vimwiki",
    url = "https://github.com/vimwiki/vimwiki"
  },
  ["vimwiki-reviews-lua"] = {
    loaded = true,
    path = "/home/ensar/.local/share/nvim/site/pack/packer/start/vimwiki-reviews-lua",
    url = "https://github.com/esensar/vimwiki-reviews-lua"
  }
}

time([[Defining packer_plugins]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
