return function ()
  local state_key = 'ZoomedState'
  local win = vim.api.nvim_get_current_win()
  local tabwins = vim.api.nvim_tabpage_list_wins(0)
  local is_zoomed = vim.fn.exists('w:'..state_key) == 1

  if #tabwins == 0 then
    if is_zoomed then
      vim.api.nvim_win_del_var(win, state_key)
    end
    return
  end

  if is_zoomed then
    local state = vim.api.nvim_win_get_var(win, state_key)
    vim.api.nvim_win_set_height(win, state.height)
    vim.api.nvim_win_set_width(win, state.width)
    vim.api.nvim_win_del_var(win, state_key)
    return
  end

  local state = {
    height = vim.api.nvim_win_get_height(win),
    width = vim.api.nvim_win_get_width(win),
  }
  vim.api.nvim_win_set_var(win, state_key, state)
  vim.api.nvim_win_set_height(win, vim.o.lines)
  vim.api.nvim_win_set_width(win, vim.o.columns)
end
