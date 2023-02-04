local telescopeTheme = require('telescope.themes')

local themeMini = {
  layout_strategy = 'vertical',
  layout_config = {
    width = 0.9,
  },
}

local function responsiveTelescope (builtin)
  return function ()
    local columns = vim.opt.columns:get()
    local theme

    if columns >= 188 then
      theme = nil
    elseif columns >= 142 then
      theme = telescopeTheme.get_ivy({})
    else
      theme = themeMini
    end
    builtin(theme)
  end
end

return responsiveTelescope
