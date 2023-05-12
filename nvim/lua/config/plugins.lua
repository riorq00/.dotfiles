local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status, lazy = pcall(require, "lazy")
if not status then
  return
end

lazy.setup({
  {
    "uga-rosa/translate.nvim",
    event = "LspAttach",
    cmd = "Translate",
    config = function()
      require("translate").setup({
        default = {
          output = "replace",
        },
        preset = {
          output = {
            replace = {
              append = true,
            },
          },
        },
      })
    end,
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "andreyorst/SimpleClangFormat.vim",
    enabled = false,
    event = "VeryLazy",
    cmd = "ClangFormat",
  },
  {
    "fsouza/prettierd",
    cmd = "Prettierd",
    event = "BufEnter",
  },

  {
    "gpanders/editorconfig.nvim",
    event = "VeryLazy",
  },

  {
    "folke/tokyonight.nvim",
    enabled = false,
    priority = 1000,
    lazy = true,
    event = "BufEnter",
    config = function()
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "jose-elias-alvarez/typescript.nvim",
    event = "VeryLazy",
    ft = { "typescript", "tsx" },
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
  },
  {
    "tjdevries/colorbuddy.nvim",
  },

  {
    "svrana/neosolarized.nvim",
    priority = 2000,
    lazy = true,
    event = "BufEnter",
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
  }, -- Statusline

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    "nvim-lua/plenary.nvim",
    event = "VeryLazy",
  }, -- Common utilities

  {
    "onsails/lspkind-nvim",
    event = "VeryLazy",
  }, -- vscode-like pictograms

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    version = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  }, -- Completion

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    event = "VeryLazy",
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  }, -- LSP

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
  }, -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua

  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
  }, -- LSP UIs

  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    --[[ build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end, ]]
    build = ":TSUpdate",
  },

  {
    "nvim-tree/nvim-web-devicons", -- File icons
    lazy = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    tag = "0.1.1",
    event = "VeryLazy",
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
  },

  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
  },

  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },

  {
    "akinsho/flutter-tools.nvim",
    enabled = false,
    event = "VeryLazy",
  },

  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
  },
  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    cmd = { "PeekOpen", "PeekClose" },
    config = function()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
    event = "VeryLazy",
  },

  {
    "dinhhuy258/git.nvim",
    event = "VeryLazy",
  }, -- For git blame & browse
}, {
  defaults = { lazy = true },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = true,
    concurrency = 2,
  },
  concurrency = 10,
  performance = {
    cache = {
      enabled = true,
    },
    disable_events = { "UIEnter", "BufReadPre" },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
