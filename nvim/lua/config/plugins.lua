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
    "nvimdev/indentmini.nvim",
    event = "BufEnter",
    enabled = false,
    config = function()
      require("indentmini").setup({
        char = "|",
        exclude = {
          "erlang",
          "markdown",
        },
      })
      -- use comment color
      vim.cmd.highlight("default link IndentLine Comment")
    end,
  },
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    event = "VeryLazy",
  },
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
    event = "VeryLazy",
  },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("rust-tools").setup()
    end,
    event = "VeryLazy",
  },
  {
    "andreyorst/SimpleClangFormat.vim",
    enabled = false,
    ft = "c",
    event = "VeryLazy",
    cmd = "ClangFormat",
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
  },
  {
    "fsouza/prettierd",
    ft = { "javascript", "css", "html", "tsx", "typescript", "javascriptreact" },
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
    enabled = false
  },

  {
    "svrana/neosolarized.nvim",
    priority = 99,
    lazy = true,
    event = "BufEnter",
    version = "*",
    enabled = false,
  },

  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd [[colorscheme solarized-osaka]]
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
  },

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
    },
  }, -- Completion

  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    enabled = true,
    version = "*",
    event = "VeryLazy",
  },

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
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
  }, -- LSP UIs

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
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
    tag = "nerd-v2-compat",
    lazy = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    branch = "0.1.x",
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
    ft = "flutter",
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
    ft = "markdown",
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
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
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
