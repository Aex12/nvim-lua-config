local kutil = require('utils.keymap')
local nnoremap = kutil.nnoremap

nnoremap('<C-j>', '<C-d>')
nnoremap('<C-k>', '<C-u>')
nnoremap('<C-b>', ':Neotree toggle<CR>')

-- lsp related
vim.keymap.set('n', 'ge', function()
  vim.diagnostic.goto_next()
  vim.diagnostic.open_float()
end)

vim.keymap.set('n', 'gE', function()
  vim.diagnostic.goto_prev()
  vim.diagnostic.open_float()
end)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
nnoremap('<leader>fo', ':Telescope resume<CR>')
