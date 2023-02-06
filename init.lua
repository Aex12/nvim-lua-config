local instance_name = 'nvim-lua'

local home_path   = vim.fn.expand('~')
local data_path   = home_path .. '/.local/share/' .. instance_name
local config_path = home_path .. '/.config/' .. instance_name
local cache_path  = home_path .. '/.cache/' .. instance_name

local old_stdpath = vim.fn.stdpath
vim.fn.stdpath = function(value)
  if value == 'data' then
    return data_path
  elseif value == 'config' then
    return config_path
  elseif value == 'cache' then
    return cache_path
  end
  return old_stdpath(value)
end

vim.opt.runtimepath:remove(home_path .. '/.config/nvim')
vim.opt.packpath:remove(home_path .. '/.local/share/nvim/site')

vim.opt.runtimepath:append(config_path)
vim.opt.packpath:append(data_path .. '/site')

local lazypath = data_path .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- this should go first always
require('plugins')

-- this should run before VimEnter if not, there will be graphical issues
require('appearance.init')
require('options')
require('commands')
require('lsp.lsp')

-- lazy load keymaps and lsp
vim.api.nvim_create_autocmd({'VimEnter'}, {
  pattern = '*',
  callback = function ()
    require('keymap.keymap').vim()
  end
})
