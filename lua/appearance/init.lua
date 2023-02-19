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

-- GUI OPTIONS
if require('util.gui_running') then
  -- set guifont
	vim.cmd [[set guifont=Hack_NF:h12]]

  -- set cursor to 'a', unset cursor on focus lost to avoid moving cursor when refocusing
  vim.cmd('set mouse=a')
  vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
    pattern = '*',
    command = 'set mouse=a',
  })
  vim.api.nvim_create_autocmd('FocusLost', {
    pattern = '*',
    command = 'set mouse=',
  })
end

-- Neovide specific
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.0133
end

