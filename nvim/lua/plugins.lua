return {
  -- colorscheme
  {
    "rebelot/kanagawa.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("settings.colorscheme")
    end,
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

  -- Vimdoc
  {
    "vim-jp/vimdoc-ja",
    keys = {
      { "h", mode = "c" },
    },
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
      "nvimtools/none-ls.nvim",
      "nvim-lua/plenary.nvim",
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

  {
    "yetone/avante.nvim",
    build = "make",
    cmd = "Copilot",
    version = false,
    opts = {
      -- auto_suggestions_provider = "copilot",
      provider = "openai",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "o4-mini-2025-04-16",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.3,
            max_completion_tokens = 8192,
          },
        },
        copilot = {
          model = "claude-sonnet-4",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.3,
            max_tokens = 4096,
          },
        },
        ollama = {
          endpoint = "http://localhost:11434",
          model = "qwen2.5-coder:7b",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.3,
            max_tokens = 4096,
          },
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        cmd = "Copilot",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
