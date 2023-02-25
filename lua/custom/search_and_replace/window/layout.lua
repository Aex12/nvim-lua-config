local Layout = require('nui.layout')

local find_popup = require('custom.search_and_replace.window.popup_find')
local files_popup = require('custom.search_and_replace.window.popup_files')
local preview_popup = require('custom.search_and_replace.window.popup_preview')

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
      Layout.Box(files_popup, { size = '80%' }),
    }, { dir = 'col', size = '40%' }),
    Layout.Box(preview_popup, { size = '60%' }),
  }, { dir = 'row' })
)

return layout
