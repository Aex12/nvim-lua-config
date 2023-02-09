local cmp_ok, cmp = pcall(require, 'cmp')
local luasnip_ok, luasnip = pcall(require, 'luasnip')
local lspkind_ok, lspkind = pcall(require, 'lspkind')
local keymap_ok, keymap = pcall(require, 'keymap.keymap')

if not (cmp_ok and luasnip_ok and lspkind_ok and keymap_ok) then
  return
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
  mapping = keymap.cmp,
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'nvim_lsp_signature_help' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function ()
          return vim.api.nvim_list_bufs()
        end
      },
    },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    -- { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function ()
          return vim.api.nvim_list_bufs()
        end
      },
    },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  -- view = {
  --   entries = { name = 'wildmenu', separator = ' | ' },
  -- },
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  -- view = {
  --   entries = { name = 'wildmenu', separator = ' | ' },
  -- },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
