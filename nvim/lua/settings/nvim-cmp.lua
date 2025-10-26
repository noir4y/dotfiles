local cmp = require("cmp")
local map = cmp.mapping

cmp.setup({
  mapping = map.preset.insert({
    ['<Tab>'] = map.select_next_item(),
    ['<S-Tab>'] = map.select_prev_item(),
    ["<C-d>"] = map.scroll_docs(-4),
    ["<C-f>"] = map.scroll_docs(4),
    ["<C-a>"] = map.complete(),
    ["<C-e>"] = map.abort(),
    ["<CR>"] = map.close(),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp", keyword_length = 2, max_item_count = 10 },
    { name = "nvim_lsp_signature_help" },
    { name = "vsnip", keyword_length = 2, max_item_count = 10 },
    { name = "buffer", keyword_length = 2, max_item_count = 10 },
    { name = "calc", keyword_length = 2, max_item_count = 10 },
  }),

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
    }, {
      { name = "buffer" },
    }),
  }),

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline", keyword_length = 2 },
    }),
  }),
})
