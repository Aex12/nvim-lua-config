local events = require("util.autocmd.events")

local makePopup = require('custom.search_and_replace.window.popup_base')

local popup_files = makePopup('Files')

popup_files:on(events.BufAdd, function ()
  local NuiTree = require("nui.tree")

  local tree = NuiTree({
    bufnr = popup_files.bufnr,
    nodes = {
      NuiTree.Node({ text = "src/core/init.lua" }, {}),
      NuiTree.Node({ text = "src/utils/find.lua" }, {
        NuiTree.Node({ text = "b-1" }, {}),
        NuiTree.Node({ text = { "b-2", "b-3" } }, {}),
      }),
    },
  })

  tree:render()
end, { once = true })

return popup_files
