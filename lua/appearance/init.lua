-- format to use on tab labels
vim.o.guitablabel = '[%N] %t %M'

-- mostrar numero de linea
vim.o.nu = true

-- always show signcolumn along with line number column
vim.o.signcolumn = 'yes'

-- show tabs as char. Also show trailing spaces
vim.o.list = true
vim.o.listchars = 'tab:| ,trail:·'

-- dont show insert/replace/visual on status line (already using lightline)
vim.o.showmode = false

-- indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- colors
vim.o.termguicolors = true

-- one single statusbar
vim.o.laststatus = 3

vim.cmd('colorscheme kanagawa')
