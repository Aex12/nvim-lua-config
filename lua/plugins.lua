-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  ------------- Lua plugins --------------
  -- TreeSitter based highlighting.
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config = function() require'nvim-treesitter.configs'.setup {
      ensure_installed = { "c", "lua", "vim", "help", "javascript", "typescript" },
      auto_install = true,
    } end
  }

  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-vsnip' }
  use { 'hrsh7th/vim-vsnip' }

  -- File finder
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      { 'gbrlsnchs/telescope-lsp-handlers.nvim' }
    },
    config = function ()
      local telescope = require('telescope')
      telescope.load_extension('lsp_handlers')
    end
  }

  -- file explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function ()
      require('nvim-tree').setup()
    end
  }

  -- statusline
  use {
    'glepnir/galaxyline.nvim', branch = 'main',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    -- your statusline
    -- config = function()
      -- require('my_statusline')
    -- end,
  }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- create custom color schemes
  -- use {'tjdevries/colorbuddy.vim' }


  ------------- VimScript plugins --------------
  -- close brackets
  use { 'rstacruz/vim-closer', event = 'VimEnter' }
  use { 'tpope/vim-endwise', event = 'VimEnter' }

  -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text. It extends vim's % key to language-specific words instead of just single characters.
  use {'andymass/vim-matchup', event = 'VimEnter'}

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
  -- Also run code after load (see the "config" key)
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
