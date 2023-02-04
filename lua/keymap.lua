
-- import utils for mapping keys
local kutil = require('keymap-util')

local nnoremap = kutil.nnoremap
-- local vnoremap = kutil.vnoremap
local tnoremap = kutil.tnoremap

-- mapleader space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- C-j and C-k for half screen navigation
nnoremap("<C-j>", "<C-d>")
nnoremap("<C-k>", "<C-u>")

-- gp select recently pasted text
nnoremap("gp", "`[v`]")

-- tab navigation
nnoremap("<leader>1", ":1tabnext<CR>")
nnoremap("<leader>2", ":2tabnext<CR>")
nnoremap("<leader>3", ":3tabnext<CR>")
nnoremap("<leader>4", ":4tabnext<CR>")
nnoremap("<leader>5", ":5tabnext<CR>")
nnoremap("<leader>6", ":6tabnext<CR>")
nnoremap("<leader>7", ":7tabnext<CR>")
nnoremap("<leader>8", ":8tabnext<CR>")
nnoremap("<leader>9", ":9tabnext<CR>")

-- move tabs
nnoremap("<leader><Left>", ":tabmove -1<CR>")
nnoremap("<leader><Right>", ":tabmove +1<CR>")

-- ESC exits terminal mode
tnoremap("Esc>", [[<C-\><C-n>]])

-- This unsets the "last search pattern" register by hitting return
nnoremap("<CR>", ":noh<CR>")

-- Telescope
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")
nnoremap("<leader>fb", ":Telescope buffers<CR>")
nnoremap("<leader>fh", ":Telescope help_tags<CR>")

nnoremap('<leader>tt', ':Neotree toggle<CR>')
nnoremap('<leader>tf', ':Neotree reveal<CR>')
