local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort" },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
	formatters = {
		black = {
			prepend_args = { "-S" },
		},
	},
})

vim.keymap.set("n", "<space>f", conform.format)
vim.keymap.set("n", "<space>F", function()
	conform.format({ formatters = { "black" } })
end)
