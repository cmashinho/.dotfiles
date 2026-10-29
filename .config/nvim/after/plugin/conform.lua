local conform = require "conform"
conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort" },
    json = { "jq" },
    c = { lsp_format = "never" },
    go = { "goimports", "gofmt" },
  },
  format_on_save = function(bunnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return {
      timeout_ms = 1000,
      lsp_format = "fallback",
    }
  end,
  formatters = {
    indent = {
      command = "/usr/bin/indent",
    },
    black = {
      prepend_args = { "-S" },
    },
    stylua = {
      append_args = { "--config-path", "/home/artemsheldyaev/.config/nvim/stylua.toml" },
    },
  },
}

require("conform").setup {
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "never" }
  end,
}

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.keymap.set("n", "<space>f", conform.format)
vim.keymap.set("n", "<space>F", function()
  conform.format { formatters = { "black", "indent" } }
end)
