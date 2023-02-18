local themeMini = {
  layout_strategy = 'vertical',
  layout_config = {
    width = 0.9,
  },
}

local function getTelescopeTheme ()
  local columns = vim.opt.columns:get()
  local theme

  if columns >= 188 then
    theme = nil
  else
    theme = themeMini
  end

  return theme
end

return getTelescopeTheme
