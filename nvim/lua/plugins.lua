return {
  -- colorscheme
  {
    "rebelot/kanagawa.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("settings.colorscheme")
    end,
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("settings.dashboard")
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("settings.treesitter")
    end,
  },

  -- Indent Line
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("settings.ibl")
    end,
  },

  -- Airline
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("settings.lualine")
    end,
  },

  {
    "kdheepak/tabline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("tabline").setup({})
    end,
  },

  -- Filetree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
      require("settings.filetree")
    end,
  },

  -- fzf
  {
    "ibhagwan/fzf-lua",
    event = { "BufRead", "BufNewFile" },
  },

  -- Window Resize
  {
    "simeji/winresizer",
    cmd = "WinResizerStartResize",
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("settings.gitsigns")
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Translate
  {
    "noir4y/comment-translate.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("settings.translate")
    end,
  },

  -- Comment Out
  {
    "tpope/vim-commentary",
    keys = { "gcc", "V" },
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    cmd = "Mason",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.0.0",
    event = { "VimEnter" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("settings.mason-lspconfig")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("settings.nvim-cmp")
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("settings.null-ls")
    end,
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    keys = { "<F5>" },
    config = function()
      require("dap.nvim-dap")
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    keys = { "<F5>" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    keys = { "<F5>" },
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      require("dap.nvim-dap-ui")
    end,
  },

  {
    "nvim-telescope/telescope-dap.nvim",
    keys = { "<F5>" },
  },

  -- Coding Agent
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
    },
  },
}
