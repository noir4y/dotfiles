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
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local config = {
      capabilities = capabilities,
      on_attach = function(client, bufnr) end,
    }

    if server_name == "lua_ls" then
      config.settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      }
    end

    if server_name == "intelephense" then
      config.settings = {
        intelephense = {
          format = {
            enable = false,
          },
        },
      }
    end

    vim.lsp.config[server_name] = config
    vim.lsp.enable(server_name)
  end,
})
