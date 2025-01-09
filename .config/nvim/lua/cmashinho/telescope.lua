local data = assert(vim.fn.stdpath "data") --[[@as string]]
local kata_picker = require "cmashinho.plugins.kata_package_picker"

kata_picker.setup()

require("telescope").setup {
  mappings = {
    n = {
      ["<c-x>"] = require("telescope.actions").delete_buffer,
    },
  },
  extensions = {
    wrap_results = true,

    fzf = {},
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require "telescope.builtin"

local custom_search = function(package_name, cwd)
  local format = "%s> "
  local formatted_input = ""
  if package_name ~= nil then
    formatted_input = string.format(format, package_name)
  else
    formatted_input = string.format(format, "")
  end

  builtin.grep_string {
    search = vim.fn.input(formatted_input),
    cwd = cwd,
  }
end

vim.keymap.set("n", "<space>pf", builtin.find_files)
vim.keymap.set("n", "<space>pF", function()
  kata_picker.picker()
end)
vim.keymap.set("n", "<space>pS", function()
  custom_search(nil, nil)
end)
vim.keymap.set("n", "<space>ps", function()
  local package_name, cwd = kata_picker.search_root(vim.api.nvim_buf_get_name(0))
  custom_search(package_name, cwd)
end)
vim.keymap.set("n", "<space>pl", function()
  local _, cwd = kata_picker.search_root(vim.api.nvim_buf_get_name(0))
  builtin.live_grep { cwd = cwd }
end)

vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<space>pb", builtin.buffers)
