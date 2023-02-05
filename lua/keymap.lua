local responsiveTelescope = require('responsive-telescope')
local telescope = require('telescope.builtin')

-- import utils for mapping keys
local kutil = require('keymap-util')

local nnoremap = kutil.nnoremap
local vnoremap = kutil.vnoremap
local tnoremap = kutil.tnoremap
local inoremap = kutil.inoremap

-- mapleader space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- C-j and C-k for half screen navigation
nnoremap("<C-j>", "<C-d>")
nnoremap("<C-k>", "<C-u>")

-- gp select recently pasted text
nnoremap("gp", "`[v`]")

nnoremap("<Tab>", ">>")
nnoremap("<S-Tab>", "<<")
vnoremap("<Tab>", ">gv")
vnoremap("<S-Tab>", "<gv")
inoremap("<S-Tab>", "<C-D>")

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
tnoremap("<Esc>", [[<C-\><C-n>]])

-- This unsets the "last search pattern" register by hitting return
nnoremap("<CR>", ":noh<CR>")

-- Telescope
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>ff', responsiveTelescope(telescope.find_files), opts)
vim.keymap.set('n', '<leader>fg', responsiveTelescope(telescope.live_grep), opts)
vim.keymap.set('n', '<leader>fb', responsiveTelescope(telescope.buffers), opts)
vim.keymap.set('n', '<leader>fh', responsiveTelescope(telescope.help_tags), opts)

nnoremap('<leader>tt', ':Neotree toggle<CR>')
nnoremap('<leader>tf', ':Neotree reveal<CR>')
