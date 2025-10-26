require("mason-null-ls").setup()

local null_ls = require("null-ls")
local utils = require("null-ls.utils")

null_ls.setup({
  root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"),
  diagnostics_format = "#{m} (#{c}) [#{s}]",
  sources = {
    null_ls.builtins.formatting.stylua,

    -- null_ls.builtins.completion.spell,
    -- null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier.with {
      prefer_local = "node_modules/.bin",
      extra_args = {"--single-quote", "--jsx-single-quote" }
    },

    -- null_ls.builtins.diagnostics.phpstan.with({
    --     prefer_local = "vendor/bin",
    -- }),

    -- null_ls.builtins.diagnostics.phpcs.with({
    --     prefer_local = "vendor/bin",
    -- }),

    null_ls.builtins.formatting.phpcbf.with({
      extra_args = { "--standard=PSR12" },
    }),
  },
  debug = false,
})
