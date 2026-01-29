require("mason").setup()

local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
  ensure_installed = { "stylua", "prettier", "phpcbf" },
  automatic_installation = false,

  handlers = {
    prettier = function(source_name, methods)
      require("mason-null-ls").default_setup(source_name, methods, {
        extra_args = { "--single-quote", "--jsx-single-quote" },
        prefer_local = "node_modules/.bin",
      })
    end,

    phpcbf = function(source_name, methods)
      require("mason-null-ls").default_setup(source_name, methods, {
        extra_args = { "--standard=PSR12" },
      })
    end,
  },
})

null_ls.setup({
  root_dir = require("null-ls.utils").root_pattern("composer.json", "package.json", "Makefile", ".git"),
  sources = {
    null_ls.builtins.formatting.stylua.with({
      extra_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    }),
  },
})
