local dap = require("dap")
vim.fn.sign_define("DapBreakpoint", { text = "⊚", texthl = "TodoFgFIX", linehl = "", numhl = "" })

local dap_config = {
  -- python = require("dap.python"),
  -- go = require("dap.go"),
  php = require("dap.php"),
}
-- set up the debugger
for dap_name, dap_options in pairs(dap_config) do
  dap.adapters[dap_name] = dap_options.adapters
  dap.configurations[dap_name] = dap_options.configurations
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F1>", "<cmd>lua require('dap').step_over()<CR>")
map("n", "<F2>", "<cmd>lua require('dap').step_into()<CR>")
map("n", "<F3>", "<cmd>lua require('dap').step_out()<CR>")
map("n", "<F4>", "<cmd>lua require('dap').restart()<CR>")
map("n", "<F5>", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
map("n", "<F9>", "<cmd>lua require('dapui').toggle()<CR>")
map("n", "<F10>", "<cmd>lua require('dap').continue()<CR>")
