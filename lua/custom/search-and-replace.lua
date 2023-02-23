local Popup = require('nui.popup')
local Layout = require('nui.layout')
local event = require("nui.utils.autocmd").event

local border_style = 'rounded'
local win_options = {
  winblend = 8,
}

local find_popup = Popup({
  enter = true,
  border = {
    style = border_style,
    text = {
      top = ' Find ',
      top_align = 'center',
    },
  },
  win_options = win_options,
})
local files_popup = Popup({
  border = {
    style = border_style,
    text = {
      top = ' Files ',
      top_align = 'center',
    },
  },
  win_options = win_options,
})
local preview_popup = Popup({
  border = {
    style = border_style,
    text = {
      top = ' Preview ',
      top_align = 'center',
    },
  },
  focusable = false,
  win_options = win_options,
})

local layout = Layout(
  {
    position = '50%',
    size = {
      width = '90%',
      height = '94%',
    },
    relative = 'editor',
  },
  Layout.Box({
    Layout.Box({
      Layout.Box(find_popup, { size = '20%' }),
      Layout.Box(files_popup, { size = '82%' }),
    }, { dir = 'col', size = '40%' }),
    Layout.Box(preview_popup, { size = '60%' }),
  }, { dir = 'row' })
)

layout:mount()

-- local current_dir = 'row'

-- popup_one:map('n', 'r', function()
--   if current_dir == 'col' then
--     layout:update(Layout.Box({
--       Layout.Box(popup_one, { size = '40%' }),
--       Layout.Box(popup_two, { size = '60%' }),
--     }, { dir = 'row' }))
--
--     current_dir = 'row'
--   else
--     layout:update(Layout.Box({
--       Layout.Box(popup_two, { size = '60%' }),
--       Layout.Box(popup_one, { size = '40%' }),
--     }, { dir = 'col' }))
--
--     current_dir = 'col'
--   end
-- end, {})

local all_popups = {
  find_popup, files_popup, preview_popup
}

local unmount = function ()
  for _, popup in ipairs(all_popups) do
    popup:off(event.BufLeave)
  end
  layout:unmount()
end

---@param bufnr number
---@return boolean
local function is_popup_buffer (bufnr)
  for _, popup in ipairs(all_popups) do
    vim.pretty_print({ bufnr, popup.bufnr })
    if popup.bufnr == bufnr then return true end
  end
  return false
end

local on_buf_leave = function (a)
  vim.api.nvim_create_autocmd(event.BufEnter, {
    pattern = '*',
    callback = function (ctx)
      vim.api.nvim_del_autocmd(ctx.id)
      if is_popup_buffer(ctx.buf) == false then
        unmount()
      end
    end
  })
end

---@param popup NuiPopup
local map_focus_popup = function (popup)
  return function ()
    vim.api.nvim_set_current_win(popup.winid)
    vim.api.nvim_win_set_buf(popup.winid, popup.bufnr)
  end
end

local opts ={ noremap = true, silent = true }
for _, popup in ipairs(all_popups) do
  popup:map('n', 'q', unmount, opts)
  popup:on(event.BufLeave, on_buf_leave)
end

find_popup:map('n', '<Tab>', map_focus_popup(files_popup), opts)
files_popup:map('n', '<Tab>', map_focus_popup(find_popup), opts)

vim.api.nvim_buf_set_lines(find_popup.bufnr, 0, 2, false, {'Find = {', ''})
vim.api.nvim_buf_set_lines(find_popup.bufnr, 3, 4, false, {'}, Replace = {', ''})
vim.api.nvim_buf_set_lines(find_popup.bufnr, 5, 7, false, {'}, Path = {', '', '}'})
