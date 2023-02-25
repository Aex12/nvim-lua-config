local M = {}
local events = require('util.autocmd.events')

-- Constants

M.state_key = 'ZoomedState'

-- Core functions

---zooms a window, so it occupies the maximum space possble.
---use unzoom_win to revert it to its original state
---@param win number
function M.zoom_win (win)
  local state = {
    height = vim.api.nvim_win_get_height(win),
    width = vim.api.nvim_win_get_width(win),
  }
  vim.api.nvim_win_set_var(win, M.state_key, state)
  vim.api.nvim_win_set_height(win, vim.o.lines)
  vim.api.nvim_win_set_width(win, vim.o.columns)
end

---reverts zoom_win, setting original setting for the winwdow
---@param win number
function M.unzoom_win (win)
  local tabwins = #vim.api.nvim_tabpage_list_wins(win)

  if #tabwins == 0 then
    vim.api.nvim_win_del_var(win, M.state_key)
    return
  end

  local state = vim.api.nvim_win_get_var(win, M.state_key)
  vim.api.nvim_win_set_height(win, state.height)
  vim.api.nvim_win_set_width(win, state.width)
  vim.api.nvim_win_del_var(win, M.state_key)
end

-- Utility functions

---returns wether or not the current win is zoomed
---@return boolean
function M.is_active_win_zoomed ()
  return vim.fn.exists('w:'..M.state_key) == 1
end



---makes current win enter in zoomed mode. You might want to bind this.
function M.toggle_current_win_zoom ()
  local win = vim.api.nvim_get_current_win()

  if M.is_active_win_zoomed() then
    M.unzoom_win(win)
  else
    M.zoom_win(win)
  end

end

return M
