local kutil = require('keymap.util')
local responsiveTelescope = require('appearance.responsive-telescope')
local telescope_ok, telescope = pcall(require, 'telescope.builtin')
local cmp_ok, cmp = pcall(require, 'cmp')
local luasnip_ok, luasnip = pcall(require, 'luasnip')

-- import utils for mapping keys

local nnoremap = kutil.nnoremap
local vnoremap = kutil.vnoremap
local tnoremap = kutil.tnoremap
local inoremap = kutil.inoremap

-- mapleader space
local keymap = {
  vim = function ()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- C-j and C-k for half screen navigation
    nnoremap('<C-j>', '<C-d>')
    nnoremap('<C-k>', '<C-u>')

    nnoremap('gp', '`[v`]')

    nnoremap('<Tab>', '>>')
    nnoremap('<S-Tab>', '<<')
    vnoremap('<Tab>', '>gv')
    vnoremap('<S-Tab>', '<gv')
    inoremap('<S-Tab>', '<C-D>')

    -- tab navigation
    nnoremap('<leader>1', ':1tabnext<CR>')
    nnoremap('<leader>2', ':2tabnext<CR>')
    nnoremap('<leader>3', ':3tabnext<CR>')
    nnoremap('<leader>4', ':4tabnext<CR>')
    nnoremap('<leader>5', ':5tabnext<CR>')
    nnoremap('<leader>6', ':6tabnext<CR>')
    nnoremap('<leader>7', ':7tabnext<CR>')
    nnoremap('<leader>8', ':8tabnext<CR>')
    nnoremap('<leader>9', ':9tabnext<CR>')

    -- move tabs
    nnoremap('<leader><Left>', ':tabmove -1<CR>')
    nnoremap('<leader><Right>', ':tabmove +1<CR>')

    -- ESC exits terminal mode
    tnoremap('<Esc>', [[<C-\><C-n>]])

    -- This unsets the 'last search pattern' register by hitting return
    nnoremap('<CR>', ':noh<CR>')

    -- Telescope
    if telescope_ok then
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<leader>ff', responsiveTelescope(telescope.find_files), opts)
      vim.keymap.set('n', '<leader>fg', responsiveTelescope(telescope.live_grep), opts)
      vim.keymap.set('n', '<leader>fb', responsiveTelescope(telescope.buffers), opts)
      vim.keymap.set('n', '<leader>fh', responsiveTelescope(telescope.help_tags), opts)
    end

    nnoremap('<leader>tt', ':Neotree toggle<CR>')
    nnoremap('<leader>tf', ':Neotree reveal<CR>')
  end,
  lsp_on_attach = function (client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)

    vim.keymap.set('n', 'cd', '<cmd>Lspsaga peek_definition<CR>', bufopts)
    vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-e>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', ':CodeActionMenu<CR>', bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    if telescope_ok then
      vim.keymap.set('n', 'gd', responsiveTelescope(telescope.lsp_definitions), bufopts)
      vim.keymap.set('n', 'gr', responsiveTelescope(telescope.lsp_references), bufopts)
    else
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    end
  end
}

if cmp_ok and luasnip_ok then
  keymap.cmp = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if (entry ~= nil) then
          cmp.confirm({ select = false })
          return
        end
      end
      fallback()
    end, {'i', 's'}),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
  })
end

return keymap
