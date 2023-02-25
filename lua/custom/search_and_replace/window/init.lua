local lookups = {
  popup_find = 'custom.search_and_replace.window.popup_find',
  popup_files = 'custom.search_and_replace.window.popup_files',
  popup_preview = 'custom.search_and_replace.window.popup_preview',
}

local exports = setmetatable({}, {
  __index = function(t, k)
    local require_path = lookups[k]
    if not require_path then
      return
    end

    local mod = require(require_path)
    t[k] = mod

    return mod
  end,
})

return exports
