local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

mason.setup({
  ui = {
    check_outdated_packages_on_open = false,
    border = "single",
  },
})

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function common_on_attach(client, bufnr)
  if client.name == "intelephense" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
end

vim.lsp.config["lua_ls"] = {
  capabilities = capabilities,
  on_attach = common_on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

vim.lsp.config["intelephense"] = {
  capabilities = capabilities,
  on_attach = common_on_attach,
  settings = {
    intelephense = {
      format = {
        enable = false,
      },
    },
  },
}

mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "intelephense" },
  automatic_enable = true,
})
