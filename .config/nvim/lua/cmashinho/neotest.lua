require("neotest").setup({
  output = {
    open_on_run = false,
  },
  adapters = {
    require "neotest-python" {
      args = {
        "-W",
        "ignore::DeprecationWarning"
      }
    }
  }
})
