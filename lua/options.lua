-- more usable git gutter and completion (default 4000ms)
vim.o.updatetime = 300

-- enable hidden buffers
vim.o.hidden = true

-- expand tab to spaecs
vim.o.expandtab = true

-- insert when opening new terminal
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter', 'TermOpen' }, {
  pattern = 'term://*',
  command = 'startinsert',
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
    local all_wins = vim.api.nvim_list_wins()

    for _, win in ipairs(all_wins) do
      local winbuf = vim.api.nvim_win_get_buf(win)
      if (ctx.buf == winbuf) then
        vim.api.nvim_win_close(win, {})
      end
    end

    vim.api.nvim_buf_delete(ctx.buf, {})
  end
})
