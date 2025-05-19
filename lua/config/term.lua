-- insert when opening new terminal
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter', 'TermOpen' }, {
  pattern = 'term://*',
  -- command = 'startinsert',
  callback = function(ctx)
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
  callback = function(ctx)
    require('util.close_term')(ctx.buf)
  end,
})
