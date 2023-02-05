-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  ------------- Lua plugins --------------
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'

  -- TreeSitter based highlighting.
  -- commentator
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  }

  use {
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
      }
    } end
  }
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- ^ CHECK THIS ^. Custom text objects (like 'iw' for inner word), based on tree sitter

  ----- LSP Related
  -- lsp config
  use { 'neovim/nvim-lspconfig' }
  -- nvim-cmp
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  -- use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  -- snippets
  -- use { 'hrsh7th/cmp-vsnip' }
  -- use { 'hrsh7th/vim-vsnip' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  -- cmp icons on completion
  use { 'onsails/lspkind.nvim' }
  -- lsp signature
  use { 'ray-x/lsp_signature.nvim' }
  -- lsp improves
  use {
    'glepnir/lspsaga.nvim', branch = 'main',
    requires = { {'nvim-tree/nvim-web-devicons'} },
    config = function()
        require('lspsaga').setup({
           lightbulb = {
            enable = true,
            enable_in_insert = false,
            sign = false,
            sign_priority = 40,
            virtual_text = true,
          },
        })
    end,
  }
  -- lsp packagemanager
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }

	-- use {
	-- 	'RishabhRD/nvim-lsputils',
	-- 	requires = { 'RishabhRD/popfix' }
	-- }
 
  -- code actions on line show a lightbulb on sign column
  -- use {
  --   'kosayoda/nvim-lightbulb',
  --   config = function ()
  --     local lightbulb = require('nvim-lightbulb')
  --
  --     vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
  --       pattern = '*',
  --       callback = lightbulb.update_lightbulb
  --     })
  --   end,
  -- }

  -- better code action
  use {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    event = 'VimEnter',
    config = function ()
      vim.g.code_action_menu_show_details = false
      vim.g.code_action_menu_show_diff = true
      vim.g.code_action_menu_show_action_kind = true
    end
  }

  ---------- UI
  -- indentation lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function ()
      vim.cmd [[highlight IndentBlanklineChar guifg=#2A2A37 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineContextChar guifg=#3f3f4b gui=nocombine]]
      require('indent_blankline').setup {
        show_current_context = true,
        show_current_context_start = false,
      }
    end,
  }

  -- File finder
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
    },
  }

  -- tree explorer
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
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
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('appearance.statusline')
    end,
  }

  -- dasboard
  -- use {
  --   'glepnir/dashboard-nvim',
  --   event = 'VimEnter',
  --   config = function()
  --     require('dashboard').setup {
  --       -- config
  --     }
  --   end,
  --   requires = {'nvim-tree/nvim-web-devicons'}
  -- }

  -- git integration sign column
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'akinsho/bufferline.nvim', tag = 'v3.*',
    requires = 'nvim-tree/nvim-web-devicons',
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
  }

  -- motion %
  use {'andymass/vim-matchup', event = 'VimEnter'}

  use({
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require('nvim-surround').setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  })

  -- create custom color schemes
  -- use {'tjdevries/colorbuddy.vim' }


  ------------- VimScript plugins --------------
  -- close brackets
  -- use { 'rstacruz/vim-closer', event = 'VimEnter' }
  -- use { 'tpope/vim-endwise', event = 'VimEnter' }

  -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text. It extends vim's % key to language-specific words instead of just single characters.
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  ---------------- COLOR SCHEME ----------------
  -- tree sitter support
  use { 'tomasiser/vim-code-dark' }
  use { 'sainnhe/sonokai' }
  use { 'navarasu/onedark.nvim' }
  use { 'rebelot/kanagawa.nvim' }
  -- use { 'embark-theme/vim', as = 'embark' }
  -- use { 'bluz71/vim-moonfly-colors' }
  --use { 'sainnhe/gruvbox-material' }

  -------- Lazy loading -------
  -- To load a plugin with lazy loading, set:
  -- use { 'author/plugin.vim', opt = true, cmd = { 'Dispatch', 'Make' } }
  -- So :Dispatch and :Make will fire loading of the plugin

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the 'config' key)
  -- use {
    -- 'w0rp/ale',
    -- ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    -- cmd = 'ALEEnable',
    -- config = 'vim.cmd[[ALEEnable]]'
  -- }

  -- Plugins can have dependencies on other plugins
  -- use {
    -- 'haorenW1025/completion-nvim',
    -- opt = true,
    -- requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  -- }

  -- Plugins can also depend on rocks from luarocks.org:
  -- use {
    -- 'my/supercoolplugin',
    -- rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  -- }

  -- -- You can specify rocks in isolation
  -- use_rocks 'penlight'
  -- use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with call of vimscript function with argument
  -- Use nvim in textareas in the browser (security implications btw)
  -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}
end)

-- LIST OF PLUGINS NEEDED TO CHECK:
-- trouble.nvim
-- nuill-ls.nvim
