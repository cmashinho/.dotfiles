local harpoon = require("harpoon")

harpoon.setup()

vim.keymap.set("n", "<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<leader>hm", function()
	harpoon:list():add()
end)

for i = 1, 5 do
	vim.keymap.set("n", string.format("<leader>%s", i), function()
		harpoon:list():select(i)
	end)
end
