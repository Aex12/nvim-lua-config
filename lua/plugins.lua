return require('lazy').setup({
  ------------- Lua plugins --------------
  -- Lazu can manage itself
  'wbthomason/packer.nvim',

  -- TreeSitter based highlighting.
  {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config = function() require'nvim-treesitter.configs'.setup {
      ensure_installed = {
        'c', 'vim', 'help', 'dockerfile',
        'diff', 'gitcommit', 'gitignore',
        'bash', 'perl', 'lua', 'python',
        'yaml', 'json', 'jsdoc',
        'javascript', 'typescript', 'tsx', 'css', 'regex',
        'prisma', 'sql',
        'html', 'markdown', 'markdown_inline',  'php',
        'go', 'dot', 'rust', 'smali'
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      context_commentstring = {
        enable = true
      },
      matchup = {
        enable = true,
      },
    } end
  },

  -- commentator
  {
    'numToStr/Comment.nvim',
    event = 'VimEnter', lazy = true,
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim')
          .create_pre_hook(),
      })
    end
  },

  ----- LSP Related
  -- lsp config
  { 'neovim/nvim-lspconfig', lazy = true },
  -- nvim-cmp
  { 'hrsh7th/nvim-cmp', lazy = true },
  { 'hrsh7th/cmp-nvim-lsp', lazy = true },
  { 'hrsh7th/cmp-buffer', lazy = true, event = 'VimEnter' },
  { 'hrsh7th/cmp-path', lazy = true, event = 'VimEnter' },
  { 'hrsh7th/cmp-cmdline', lazy = true, event = 'VimEnter' },
  -- { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  -- snippets
  -- { 'hrsh7th/cmp-vsnip' },
  -- { 'hrsh7th/vim-vsnip' },
  { 'L3MON4D3/LuaSnip', lazy = true },
  { 'saadparwaiz1/cmp_luasnip', lazy = true, event = 'VimEnter' },
  -- cmp icons on completion
  { 'onsails/lspkind.nvim', lazy = true },
  -- lsp signature
  { 'ray-x/lsp_signature.nvim', event = 'VimEnter', lazy = true },
  -- lsp improves
  {
    'glepnir/lspsaga.nvim', branch = 'main',
    event = 'VimEnter', lazy = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = false,
        sign_priority = 40,
        virtual_text = true,
      },
    },
  },
  -- lsp packagemanager
  { 'williamboman/mason.nvim', lazy = true },
  { 'williamboman/mason-lspconfig.nvim', lazy = true },

  -- better code action
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu', lazy = true,
    config = function ()
      vim.g.code_action_menu_show_details = false
      vim.g.code_action_menu_show_diff = true
      vim.g.code_action_menu_show_action_kind = true
    end
  },

  ---------- UI
  -- indentation lines
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VimEnter', lazy = true,
    config = function ()
      vim.cmd [[highlight IndentBlanklineChar guifg=#2A2A37 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineContextChar guifg=#3f3f4b gui=nocombine]]
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = false,
      }
    end,
  },

  -- File finder
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x', lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- tree explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function ()
      -- Neotree Specific. Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require('neo-tree').setup({
        filesystem = {
          window = {
            position = 'current',
          },
          hijack_netrw_behavior = 'open_current'
        }
      })
    end
  },

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    event = 'VimEnter', lazy = true,
    config = function()
      require('appearance.statusline')
    end,
  },

  -- git integration sign column
  {
    'lewis6991/gitsigns.nvim', tag = 'release',
    event = 'VimEnter', lazy = true, config = true,
  },

  {
    'akinsho/bufferline.nvim', tag = 'v3.*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VimEnter', lazy = true,
    config = function()
      require('bufferline').setup({
        options = {
          mode = 'tabs',
          diagnostics_indicator = function(_, level)
            local icon = level:tatch('error') and ' ' or ' '
            return ' ' .. icon
          end
        },
      })
    end
  },

  -- motion %
  { 'andymass/vim-matchup', event = 'VimEnter', lazy = true },

  {
    'kylechui/nvim-surround', tag = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VimEnter', lazy = true, config = true,
  },

  {
    'ggandor/leap.nvim',
    event = 'VimEnter', lazy = true,
    dependencies = { 'tpope/vim-repeat' },
    config = function ()
      require('leap').add_default_mappings()
    end,
  },

  ---------------- COLOR SCHEME ----------------
  -- tree sitter support
  { 'rebelot/kanagawa.nvim' },
})

-- LIST OF PLUGINS NEEDED TO CHECK:
-- trouble.nvim
-- nuill-ls.nvim
  -- create custom color schemes
-- {'tjdevries/colorbuddy.vim' },
-- {
--  'RishabhRD/nvim-lsputils',
--  dependencies = { 'RishabhRD/popfix' }
-- },

