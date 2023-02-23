---receives a bufnr and close all windows containing it and deletes the buffer
---@param buf number
---@return nil
return function (buf)
  local all_wins = vim.api.nvim_list_wins()

  for _, win in ipairs(all_wins) do
    local winbuf = vim.api.nvim_win_get_buf(win)
    if (buf == winbuf) then
      vim.api.nvim_win_close(win, {})
    end
  end

  if vim.fn.bufexists(buf) == 1 then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end
