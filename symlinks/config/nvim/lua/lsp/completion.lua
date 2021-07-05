-------------------------------------------------------------------------------
--    - LSP completion config -
-------------------------------------------------------------------------------

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    ultisnips = true;
  };
}

local function set_keymap(...) vim.api.nvim_set_keymap(...) end

local default_opts = {noremap = true, silent = true, expr = true}

set_keymap('i', '<C-Space>', 'compe#complete()', default_opts)
set_keymap('i', '<C-y>', "compe#confirm('<C-y>')", default_opts)
set_keymap('i', '<C-e>', "compe#close('<C-e>')", default_opts)
set_keymap('i', '<C-f>', "compe#scroll({ 'delta': +4 })", default_opts)
set_keymap('i', '<C-d>', "compe#scroll({ 'delta': -4 })", default_opts)
