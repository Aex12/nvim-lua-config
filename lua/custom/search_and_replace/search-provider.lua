local Job = require('plenary.job')
local a = require("plenary.async")

local channel = a.control.channel

---Search a given pattern on the given cwd using a glob
---@param pattern string
---@param glob? string
---@param cwd? string
local search_pattern = function (pattern, glob, cwd)
  if (type(pattern) ~= 'string') then
    print('pattern not stirng')
    return {}
  end

  if not cwd then
    cwd = vim.fn.getcwd()
  end

  local args = {}
  if type(glob) == 'string' then
    table.insert(args, '-g')
    table.insert(args, glob)
  end

  table.insert(args, '--')
  table.insert(args, pattern)
  table.insert(args, '.')

  local setRes, getRes = channel.oneshot()
  a.run(function()
    local job = Job:new({
      command = 'rg',
      args = args,
      cwd = cwd,
      on_exit = function(j)
        local result = j:result()
        setRes(result)
      end,
    })
    job:start()
  end, nil)

  local res = getRes()
  return res
end

a.run(function ()
  local res = search_pattern('require', '**/appearance/*.lua')
  vim.pretty_print(res)
end, nil)

return search_pattern
