local Popup = require('nui.popup')

local border_style = 'rounded'

local win_options = {
  winblend = 8,
}

local base = {
  border = {
    style = border_style,
    text = {
      top_align = 'center',
    },
  },
  win_options = win_options,
}

---@param name string
---@param opts? NuiPopup | nil
local function makePopup(name, opts)
  return Popup(vim.tbl_deep_extend('force',
    { border = { text = { top = ' '..name..' ' } } },
    base,
    opts or {}
  ))
end

return makePopup
