local options = {
  -- UI
  encoding = "utf-8",
  termguicolors = true,
  title = true,
  number = true,
  cursorline = true,
  wrap = true,
  list = true,
  listchars = { tab = "»-", trail = "-", extends = "»", precedes = "«", nbsp = "%", eol = "↲" },
  showmatch = true,
  showmode = false,
  matchtime = 3,
  textwidth = 0,
  cmdheight = 1,
  conceallevel = 0,
  pumheight = 10,
  showtabline = 2,
  timeoutlen = 300,
  completeopt = { "menuone", "noselect" },

  -- Indent
  autoindent = true,
  smartindent = true,
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,

  -- Search
  ignorecase = true,
  smartcase = true,
  wrapscan = true,
  hlsearch = true,
  incsearch = true,
  inccommand = "split",

  -- Log
  backup = false,
  backupskip = { "/tmp/*", "/private/tmp/*" },
  writebackup = false,
  swapfile = false,
  undofile = true,
  updatetime = 300,
  history = 5000,
  signcolumn = "yes",

  -- Control
  clipboard = "unnamedplus",
  backspace = { "indent", "eol", "start" },
  hidden = true,
  fileformats = "unix",
  mouse = "a",
  winblend = 5,
  omnifunc = "lsp#complete",

  -- whichwrap = "b,s,h,l,[,],<,>,~",
  -- relativenumber = false,
  -- numberwidth = 4,
  -- wildoptions = "pum",
  -- pumblend = 5,
  -- scrolloff = 8,
  -- sidescrolloff = 8,
  -- guifont = "monospace:h17",
  -- splitbelow = false,
  -- splitright = false,
}

vim.opt.shortmess:append("c")
-- vim.opt.iskeyword:append{'-'}

for k, v in pairs(options) do
  vim.opt[k] = v
end
