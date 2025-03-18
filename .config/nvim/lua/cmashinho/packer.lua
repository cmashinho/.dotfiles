require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "nvim-lua/plenary.nvim"
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-smart-history.nvim",
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  }

  -- use({ "lewis6991/gitsigns.nvim" })
  use { "ThePrimeagen/harpoon", branch = "harpoon2" }
  use { "tjdevries/cyclist.vim" }

  use { "tpope/vim-fugitive" }
  use { "echasnovski/mini.ai" }
  use { "echasnovski/mini.surround" }
  use { "echasnovski/mini.icons" }
  use { "nvim-tree/nvim-web-devicons" }
  use { "stevearc/oil.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = {} } }
  use { "nvim-treesitter/nvim-treesitter" }
  use { "nvim-treesitter/nvim-treesitter-refactor" }

  use {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      { "onsails/lspkind.nvim" },
    },
  }

  use { "stevearc/conform.nvim" }
  use { "folke/lazydev.nvim" }
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-lua/plenary.nvim",
      "autoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  }
end)
