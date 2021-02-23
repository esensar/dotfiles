" Must have extensions!

lua <<EOF
local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
end

vim.g.diagnostic_enable_virtual_text = 1

default_opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<A-CR>", "<cmd>lua vim.lsp.buf.code_action()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<Leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", default_opts)
vim.api.nvim_set_keymap("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action_range()<CR>", default_opts)

lspconfig.bashls.setup {on_attach = on_attach}
lspconfig.clangd.setup {on_attach = on_attach}
lspconfig.dartls.setup {on_attach = on_attach}
lspconfig.jsonls.setup {on_attach = on_attach}
lspconfig.pyright.setup {on_attach = on_attach}
lspconfig.rust_analyzer.setup {on_attach = on_attach}
lspconfig.vimls.setup {on_attach = on_attach}

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
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

EOF

inoremap <silent><expr> <C-n> compe#complete()
inoremap <silent><expr> <C-y> compe#confirm('<C-y>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')
inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect
