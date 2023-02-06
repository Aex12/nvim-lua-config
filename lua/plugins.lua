return require('lazy').setup({
  ------------- Lua plugins --------------
  -- Packer can manage itself
  'wbthomason/packer.nvim',
  'lewis6991/impatient.nvim',

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
     -- textobjects = {
     --   select = {
     --     enable = true,
     --     lookahead = true,
     --     keymaps = {
     --       -- You can use the capture groups defined in textobjects.scm
     --       ['aa'] = '@parameter.outer',
     --       ['ia'] = '@parameter.inner',
     --       ['ab'] = '@block.outer',
     --       ['ib'] = '@block.inner',
     --       ['af'] = '@function.outer',
     --       ['if'] = '@function.inner',
     --       ['ac'] = '@class.outer',
     --       ['ic'] = '@class.inner',
     --       ['ak'] = '@call.outer',
     --       ['ik'] = '@call.inner',
     --     },
     --   },
     --   swap = {
     --     enable = true,
     --     swap_next = {
     --       ["<leader>a"] = "@parameter.inner",
     --     },
     --     swap_previous = {
     --       ["<leader>A"] = "@parameter.inner",
     --     },
     --   },
     --   move = {
     --     enable = true,
     --     set_jumps = true,
     --     goto_next_start = {
     --       ["gnF"] = "@function.outer",
     --       ["gnC"] = "@class.outer",
     --       ["gnS"] = "@scope",
     --       ["gnB"] = "@block.outer",
     --     },
     --     goto_next_end = {
     --       ["gnf"] = "@function.outer",
     --       ["gnc"] = "@class.outer",
     --       ["gns"] = "@scope",
     --       ["gnb"] = "@block.outer",
     --     },
     --     goto_previous_start = {
     --       ["gNF"] = "@function.outer",
     --       ["gNC"] = "@class.outer",
     --       ["gNS"] = "@scope",
     --       ["gNB"] = "@block.outer",
     --     },
     --     goto_previous_end = {
     --       ["gNf"] = "@function.outer",
     --       ["gNc"] = "@class.outer",
     --       ["gNs"] = "@scope",
     --       ["gNb"] = "@block.outer",
     --     },
     --     -- Below will go to either the start or the end, whichever is closer.
     --     -- Use if you want more granular movements
     --     -- Make it even more gradual by adding multiple queries and regex.
     --     -- goto_next = {
     --       -- ["]d"] = "@conditional.outer",
     --     -- },
     --     -- goto_previous = {
     --       -- ["[d"] = "@conditional.outer",
     --     -- }
     --   },
     -- },
    } end
  },

  -- use 'nvim-treesitter/nvim-treesitter-textobjects'

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
  { 'neovim/nvim-lspconfig' },
  -- nvim-cmp
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  -- { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  -- snippets
  -- { 'hrsh7th/cmp-vsnip' },
  -- { 'hrsh7th/vim-vsnip' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  -- cmp icons on completion
  { 'onsails/lspkind.nvim' },
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
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

	-- {
	-- 	'RishabhRD/nvim-lsputils',
	-- 	dependencies = { 'RishabhRD/popfix' }
	-- },

  -- code actions on line show a lightbulb on sign column
  -- {
  --   'kosayoda/nvim-lightbulb',
  --   config = function ()
  --     local lightbulb = require('nvim-lightbulb')
  --
  --     vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
  --       pattern = '*',
  --       callback = lightbulb.update_lightbulb
  --     })
  --   end,
  -- },

  -- better code action
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    event = 'VimEnter', lazy = true,
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
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
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

  -- dasboard
  -- {
  --   'glepnir/dashboard-nvim',
  --   event = 'VimEnter', lazy = true,
  --   config = function()
  --     require('dashboard').setup {
  --       -- config
  --     }
  --   end,
  --   dependencies = {'nvim-tree/nvim-web-devicons'}
  -- },

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
    event = 'VimEnter',
    dependencies = { 'tpope/vim-repeat' },
    config = function ()
      require('leap').add_default_mappings()
    end,
  },

  ---------------- COLOR SCHEME ----------------
  -- tree sitter support
  { 'tomasiser/vim-code-dark' },
  { 'sainnhe/sonokai' },
  { 'navarasu/onedark.nvim' },
  { 'rebelot/kanagawa.nvim' },
  --
  -- create custom color schemes
  -- {'tjdevries/colorbuddy.vim' },
})

-- LIST OF PLUGINS NEEDED TO CHECK:
-- trouble.nvim
-- nuill-ls.nvim
