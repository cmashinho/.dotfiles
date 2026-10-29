-- require("nvim-treesitter.configs").setup {
--   ensure_installed = { "python", "c", "lua" },
--
--   highlight = {
--     enable = true,
--   },
--   -- indent = {
--   --   enable = true,
--   -- },
--   playground = {
--     enable = true,
--   },
--   refactor = {
--     navigation = {
--       enable = true,
--       keymaps = {
--         goto_next_usage = "<C-j>",
--         goto_previous_usage = "<C-k>",
--       },
--     },
--   },
-- }
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.treesitter.start() -- highlighting
    -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- folds
    -- vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
  end,
})
