-------------------------------------------------------------------------------
--    - LSP completion config -
-------------------------------------------------------------------------------

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'buffer' },
  }
}
