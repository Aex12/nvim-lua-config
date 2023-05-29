-- more usable git gutter and completion (default 4000ms)
vim.o.updatetime = 300

-- enable hidden buffers
vim.o.hidden = true

-- expand tab to spaecs
vim.o.expandtab = true

-- insert when opening new terminal
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter', 'TermOpen' }, {
  pattern = 'term://*',
  -- command = 'startinsert',
  callback = function (ctx)
    vim.g.last_term_buffer = ctx.buf
    vim.cmd('startinsert')
  end,
})

-- disable terminal line numbers
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = 'term://*',
  command = 'setlocal nonumber norelativenumber',
})

-- autoclose term on shell exit
vim.api.nvim_create_autocmd({ 'TermClose' }, {
  pattern = 'term://*',
  callback = function (ctx)
    require('util.close_term')(ctx.buf)
  end
})

-- highlight in red nbsp
vim.cmd[[highlight IllegalChar ctermbg=red guibg=red]]
vim.cmd[[match IllegalChar / /]]
