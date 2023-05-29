local a = require("plenary.async")
local events = require("util.autocmd.events")

local makePopup = require('custom.search_and_replace.window.popup_base')
local NuiTree = require("nui.tree")

local popup_files = makePopup('Files')

local function render_find (pattern, glob, cwd)
  a.run(function ()
    local search_pattern = require('custom.search_and_replace.search-provider')
    local res = search_pattern(pattern, glob, cwd)
    return res
  end, function (res)
    vim.defer_fn(function ()
      local nodes = {}
      for _, result in ipairs(res) do
        local node = NuiTree.Node({ text = result }, {})
        table.insert(nodes, node)
      end
      local tree = NuiTree({
        bufnr = popup_files.bufnr,
        nodes = nodes,
      })

      tree:render()
    end, 0)
  end)
end

popup_files:on(events.BufWinEnter, function ()
  render_find('require', '**/custom/*.lua')
end, { once = true })

return popup_files
