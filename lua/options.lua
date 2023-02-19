-- more usable git gutter and completion (default 4000ms)
vim.o.updatetime = 300

-- enable hidden buffers
vim.o.hidden = true

-- expand tab to spaecs
vim.o.expandtab = true

-- insert when opening new terminal
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter', 'TermOpen' }, {
  pattern = 'term://*',
  command = 'startinsert',
})
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert',
})

-- disable terminal number
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = 'term://*',
  command = 'setlocal nonumber norelativenumber',
})

-- autoclose term on shell exit
vim.api.nvim_create_autocmd({ 'TermClose' }, {
  pattern = 'term://*',
  command = 'q',
})
