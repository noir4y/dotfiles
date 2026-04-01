require("mason").setup()

local null_ls = require("null-ls")
local mason_null_ls = require("mason-null-ls")
local utils = require("null-ls.utils")

mason_null_ls.setup({
  ensure_installed = { "stylua", "prettier", "phpcbf" },
  automatic_installation = false,
})

null_ls.setup({
  root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"),
  sources = {
    null_ls.builtins.formatting.stylua.with({
      extra_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    }),
    null_ls.builtins.formatting.prettier.with({
      extra_args = { "--single-quote", "--jsx-single-quote" },
      prefer_local = "node_modules/.bin",
    }),
    null_ls.builtins.formatting.phpcbf.with({
      extra_args = function(params)
        local standard = utils.root_pattern("phpcs.xml", "phpcs.xml.dist")(params.bufname)

        if standard then
          return { "--standard=" .. standard }
        end

        return { "--standard=" .. vim.fn.expand("~/.codesniffer/phpcs.xml") }
      end,
    }),
  },
})
