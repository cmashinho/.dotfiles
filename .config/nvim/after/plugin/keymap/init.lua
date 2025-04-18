local Remap = require "cmashinho.keymap"
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nmap("<leader>pv", ":Oil<CR>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
--
-- nnoremap("Y", "yg$")
-- nnoremap("n", "nzzzv")
-- nnoremap("N", "Nzzzv")
-- nnoremap("J", "mzJ`z")
-- nnoremap("<C-d>", "<C-d>zz")
-- nnoremap("<C-u>", "<C-u>zz")
--
-- -- greatest remap ever
xnoremap("<leader>p", '"_dP')
--
-- -- next greatest remap ever : asbjornHaland
-- nnoremap("<leader>y", '"+y')
-- vnoremap("<leader>y", '"+y')
-- nmap("<leader>Y", '"+Y')
-- nmap("<leader>cf", ":let @+=@%<CR>")
--
-- nnoremap("<leader>d", '"_d')
-- vnoremap("<leader>d", '"_d')
--
-- vnoremap("<leader>d", '"_d')
--
-- -- This is going to get me cancelled
-- inoremap("<C-c>", "<Esc>")
--
-- nnoremap("Q", "<nop>")
-- -- nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- nnoremap("<leader>f", function()
-- 	vim.lsp.buf.format()
-- end)
--
-- -- nnoremap("<C-k>", "<cmd>cnext<CR>zz")
-- -- nnoremap("<C-j>", "<cmd>cprev<CR>zz")
-- nnoremap("<leader>k", "<cmd>lnext<CR>zz")
-- nnoremap("<leader>j", "<cmd>lprev<CR>zz")
--
-- nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--
-- nnoremap("<leader><leader>x", "<cmd>source %<CR>")
nnoremap("<leader>tt", function()
  require("neotest").run.run()
end)

nnoremap("<leader>ts", function()
  require("neotest").run.stop()
end)

nnoremap("<leader>ta", function()
  require("neotest").run.attach()
end)

nnoremap("<leader>to", function()
  require("neotest").output.open { enter = true }
end)

nnoremap("<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end)
