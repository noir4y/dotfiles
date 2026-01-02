local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- Remap space as leader key
vim.g.mapleader = " "

-- Move cursor
map("n", "j", "gj", opt)
map("n", "k", "gk", opt)
map("n", "J", "^", opt)
map("n", "K", "$", opt)

if vim.g.vscode then
  map("n", "<leader>f", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", opt)
  map("n", "<leader>o", "<cmd>call VSCodeNotify('workbench.action.files.openLocalFileFolder')<CR>", opt)
  map("n", "<leader>l", "<cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>", opt)
  map("n", "<leader>h", "<cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>", opt)
  map("n", "<leader>v", "<cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>", opt)
  map("n", "<leader>s", "<cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", opt)
else
  -- ESC
  map("i", "jj", "<ESC>", opt)
  map("i", "ｊｊ", "<ESC>", opt)
  map("n", "<Esc><Esc>", ":<C-u>nohl<CR>", opt)

  -- Split window
  map("n", "<leader>v", "<cmd>vs<CR>", opt)
  map("n", "<leader>s", "<cmd>sp<CR>", opt)

  -- Better window navigation
  map("n", "<leader>h", "<C-w>h", opt)
  map("n", "<leader>j", "<C-w>j", opt)
  map("n", "<leader>k", "<C-w>k", opt)
  map("n", "<leader>l", "<C-w>l", opt)

  -- LSP
  map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
  map("n", "<A-f>", "<cmd>lua vim.lsp.buf.format()<CR>", opt)
  map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  map("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
  map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
  map("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
  map("n", "<leader>)", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
  map("n", "<leader>(", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)

  -- fzf
  vim.cmd([[
    highlight FzfLuaNormal guibg=#383850
    highlight FzfLuaBorder guibg=#383850
  ]])

  map("n", "<leader>f", '<cmd>lua require("fzf-lua").files()<CR>', opt)
  map("n", "<leader>g", '<cmd>lua require("fzf-lua").live_grep()<CR>', opt)
  map("n", "<leader>b", '<cmd>lua require("fzf-lua").buffers()<CR>', opt)
  map("n", "<leader>e", '<cmd>lua require("fzf-lua").git_status()<CR>', opt)

  -- Airline
  map("n", "<C-p>", "<cmd>bprevious<CR>", opt)
  map("n", "<C-n>", "<cmd>bnext<CR>", opt)

  -- Filetree
  map("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", opt)

  -- WindowResize
  vim.g["winresizer_start_key"] = "<Leader>w"
  map("n", "<leader>w", "<cmd>WinResizerStartResize<CR>", opt)

  -- Avante
  map("n", "<leader>ao", '<cmd>lua require("avante.api").add_buffer_files()<CR>', opt)
  map("n", "<leader>ap", '<cmd>AvanteStop<CR>', opt)
end
