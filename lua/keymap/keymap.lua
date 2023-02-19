local kutil = require('keymap.util')
local responsiveTelescope = require('appearance.responsive-telescope')
local telescope_ok, telescope = pcall(require, 'telescope.builtin')
local cmp_ok, cmp = pcall(require, 'cmp')
local luasnip_ok, luasnip = pcall(require, 'luasnip')
-- local ts_repeat_move_ok, ts_repeat_move = pcall(require, 'nvim-treesitter.textobjects.repeatable_move')
local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')

-- import utils for mapping keys

local nnoremap = kutil.nnoremap
local vnoremap = kutil.vnoremap
local tnoremap = kutil.tnoremap
local inoremap = kutil.inoremap

-- mapleader space
local keymap = {
  vim = function ()
    local opts = { noremap = true, silent = true }

    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
    vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>', opts)

    -- C-j and C-k for half screen navigation
    nnoremap('<C-j>', '<C-d>')
    nnoremap('<C-k>', '<C-u>')

    nnoremap('gp', '`[v`]')

    nnoremap('<Tab>', '>>')
    nnoremap('<S-Tab>', '<<')
    vnoremap('<Tab>', '>gv')
    vnoremap('<S-Tab>', '<gv')
    inoremap('<S-Tab>', '<C-D>')

    nnoremap('<C-p>', '<C-i>')

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

    nnoremap('<C-Up>', ':resize -1<CR>')
    nnoremap('<C-Down>', ':resize +1<CR>')
    nnoremap('<C-Left>', ':vertical resize -1<CR>')
    nnoremap('<C-Right>', ':vertical resize +1<CR>')

    -- move tabs
    nnoremap('<leader><Left>', ':tabmove -1<CR>')
    nnoremap('<leader><Right>', ':tabmove +1<CR>')

    -- ESC exits terminal mode
    tnoremap('<Esc>', [[<C-\><C-n>]])

    -- This unsets the 'last search pattern' register by hitting return
    nnoremap('<CR>', ':noh<CR>')

    -- Telescope
    if telescope_ok then
      vim.keymap.set('n', '<leader>fr', responsiveTelescope(telescope.resume), opts)
      vim.keymap.set('n', '<leader>ff', responsiveTelescope(telescope.find_files), opts)
      vim.keymap.set('n', '<leader>fg', responsiveTelescope(telescope.live_grep), opts)
      vim.keymap.set('n', '<leader>fb', responsiveTelescope(telescope.buffers), opts)
      vim.keymap.set('n', '<leader>fh', responsiveTelescope(telescope.help_tags), opts)
    end

    -- if ts_repeat_move_ok then
    --   -- Repeat movement with ; and ,
    --   -- ensure ; goes forward and , goes backward regardless of the last direction
    --   vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_next)
    --   vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_previous)
    --
    --   -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    --   vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
    --   vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
    --   vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
    --   vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
    --
    --   if gitsigns_ok then
    --     -- make sure forward function comes first
    --     local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(
    --       gitsigns.next_hunk, gitsigns.prev_hunk
    --     )
    --     -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
    --
    --     vim.keymap.set({ 'n', 'x', 'o' }, '<leader>gg', next_hunk_repeat)
    --     vim.keymap.set({ 'n', 'x', 'o' }, '<leader>gG', prev_hunk_repeat)
    --   end
    -- end

    nnoremap('<leader>tt', ':Neotree toggle<CR>')
    nnoremap('<leader>tf', ':Neotree reveal<CR>')
    nnoremap('<leader>tb', ':Neotree reveal buffers<CR>')

    if gitsigns_ok then
      local opts = { noremap = true, silent = true }

      vim.keymap.set('n', 'gh', function ()
        local actions = gitsigns.get_actions()
        if actions.blame_line ~= nil then
          return actions.blame_line()
        end
        if actions.preview_hunk ~= nil then
          return actions.preview_hunk()
        end
      end, opts)
    end


    if require('util.gui_running') then
      -- Copy to global register
      vim.keymap.set({'n'}, '<D-c>', '"+yy', opts)
      vim.keymap.set({'x'}, '<D-c>', '"+y', opts)

      vim.keymap.set({'n'}, '<D-x>', '"+dd', opts)
      vim.keymap.set({'x'}, '<D-x>', '"+d', opts)

      -- Paste from global register
      vim.keymap.set({'n', 'x'}, '<D-v>', '"+p', opts)
      vim.keymap.set({'c', 'i'}, '<D-v>', '<C-r>"', opts)

      -- Tabs
      vim.keymap.set({'n'}, '<D-t>', '<cmd>tabe .<cr>', opts)
      vim.keymap.set({'n'}, '<C-Tab>', 'gt', opts)
      vim.keymap.set({'n'}, '<C-S-Tab>', 'gT', opts)
    end

    -- termial binds
    vim.keymap.set({ 'n', 'x' }, '<leader>cc', '<cmd>belowright split | resize 12 | terminal<CR>', opts)
    vim.keymap.set({ 'n', 'x' }, '<C-W>"', '<cmd>belowright split | resize 24 | terminal<CR>', opts)
  end,

  lsp_on_attach = function (client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)

    vim.keymap.set('n', 'cd', '<cmd>Lspsaga peek_definition<CR>', bufopts)
    vim.keymap.set('n', 'ga', '<cmd>Lspsaga lsp_finder<CR>', bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-e>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>', bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- if 1 definition, jump directly, otherwise show custom telescope picker
    local lsp_goto = require('custom.lsp_goto')
    vim.keymap.set('n', 'gd', lsp_goto('definition'), bufopts)
    vim.keymap.set('n', 'gr', lsp_goto('references'), bufopts)
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
    end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  })
end

return keymap
