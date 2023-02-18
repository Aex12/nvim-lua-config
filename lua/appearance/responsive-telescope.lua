local getTelescopeTheme = require('appearance.get-telescope-theme')

local function responsiveTelescope (builtin)
  return function ()
    builtin(getTelescopeTheme())
  end
end

return responsiveTelescope
