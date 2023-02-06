local expand = vim.fn.expand
local instance_name = 'nvim-lua'

local old_stdpath = vim.fn.stdpath
vim.fn.stdpath = function(value)
    if value == 'data' then
        return expand('~/.local/share/' .. instance_name)
    end
    if value == 'config' then
        return expand('~/.config/' .. instance_name)
    end
    if value == 'cache' then
        return expand('~/.cache/' .. instance_name)
    end
    return old_stdpath(value)
end

vim.opt.runtimepath:remove(expand('~/.config/nvim'))
vim.opt.packpath:remove(expand('~/.local/share/nvim/site'))

vim.opt.runtimepath:append(expand('~/.config/' .. instance_name ))
vim.opt.packpath:append(expand('~/.local/share/' .. instance_name .. '/site'))

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

-- this should go first always
require('plugins')

-- this should run before VimEnter if not, there will be graphical issues
require('appearance.init')
require('options')
require('commands')

-- lazy load keymaps and lsp
vim.api.nvim_create_autocmd({'VimEnter'}, {
  pattern = '*',
  callback = function ()
    require('lsp.lsp')
    require('keymap.keymap').vim()
  end
})
