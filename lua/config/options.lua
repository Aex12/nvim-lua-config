-- more usable git gutter and completion (default 4000ms)
vim.o.updatetime = 300

-- enable hidden buffers
vim.o.hidden = true

-- dont show insert/replace/visual on status line (already using custom status line)
vim.o.showmode = false

-- mostrar numero de linea
vim.o.nu = true

-- always show signcolumn along with line number column
vim.o.signcolumn = 'number'

-- indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- expand tab to spaces
vim.o.expandtab = true

-- show tabs as char. Also show trailing spaces
vim.o.list = true
vim.o.listchars = 'tab:| ,trail:·'

-- colors
vim.o.termguicolors = true

-- one single statusbar
vim.o.laststatus = 3

vim.cmd('colorscheme kanagawa')
vim.cmd('set mouse=')
