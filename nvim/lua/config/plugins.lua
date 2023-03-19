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

local ok, lazy = pcall(require, "lazy")
if not ok then
  return
end

lazy.setup({
  {
    "uga-rosa/translate.nvim",
    event = "BufRead",
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
    "fsouza/prettierd",
    cmd = "Prettierd",
    event = "BufEnter",
  },

  {
    "gpanders/editorconfig.nvim",
  },

  {
    "folke/tokyonight.nvim",
    enabled = true,
    priority = 1000,
    lazy = true,
    event = "BufEnter",
    config = function()
      --      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "jose-elias-alvarez/typescript.nvim",
  },

  {
    "rhysd/vim-clang-format",
    config = true,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
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
  }, -- Common utilities

  {
    "onsails/lspkind-nvim",
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
    config = function() end,
  }, -- LSP UIs

  {
    "L3MON4D3/LuaSnip",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  },

  {
    "kyazdani42/nvim-web-devicons", -- File icons
    lazy = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
  },

  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
  },

  {
    "windwp/nvim-ts-autotag",
  },
  {
    "norcalli/nvim-colorizer.lua",
  },

  {
    "akinsho/flutter-tools.nvim",
  },

  {
    "folke/zen-mode.nvim",
  },

  {
    "iamcco/markdown-preview.nvim",
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
    "dinhhuy258/git.nvim",
  }, -- For git blame & browse
}, {
  defaults = { lazy = true },
  checker = {
    enabled = true,
    concurrency = 2,
  },
  concurrency = 10,
  performance = {
    cache = {
      enabled = true,
    },
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
