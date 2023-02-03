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

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- this should go first always
require('plugins')
require('lsp')

-- a list of vim opts
require('options')
require('keymap')
require('commands')
