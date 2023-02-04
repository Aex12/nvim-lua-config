local telescopeTheme = require('telescope.themes')

local function responsiveTelescope (builtin)
  return function ()
    local columns = vim.opt.columns:get()
    local theme

    if columns >= 188 then
      theme = nil
    elseif columns >= 142 then
      theme = telescopeTheme.get_ivy({})
    else
      theme = telescopeTheme.get_dropdown({})
    end
    builtin(theme)
  end
end

return responsiveTelescope
