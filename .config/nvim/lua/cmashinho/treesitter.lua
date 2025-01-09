require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "c", "lua" },

  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true
  },
  refactor = {
    navigation = {
      enable = true,
      keymaps = {
        goto_next_usage = "<C-j>",
        goto_previous_usage = "<C-k>",
      }
    }
  }
})
