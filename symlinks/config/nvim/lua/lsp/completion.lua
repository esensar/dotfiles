-------------------------------------------------------------------------------
--    - LSP completion config -
-------------------------------------------------------------------------------

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({select = true}),
        ["<C-n>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ["<C-p>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },
    sources = {
        {name = "nvim_lsp"},
        {name = "nvim_lua"},
        {name = "path"},
        {name = "ultisnips"},
        {name = "buffer"}
    }
}
