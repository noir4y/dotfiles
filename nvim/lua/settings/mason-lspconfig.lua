require("mason").setup({
  ui = {
    check_outdated_packages_on_open = false,
    border = "single",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "intelephense" },
})

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
})
