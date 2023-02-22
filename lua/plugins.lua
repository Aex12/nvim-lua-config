return require('lazy').setup({
  ------------- Lua plugins --------------
  -- Lazu can manage itself
  'wbthomason/packer.nvim',

  -- TreeSitter based highlighting.
  {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
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
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ak'] = '@call.outer',
              ['ik'] = '@call.inner',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["gnF"] = "@function.outer",
              ["gnC"] = "@class.outer",
              ["gnS"] = "@scope",
              ["gnB"] = "@block.outer",
            },
            goto_next_end = {
              ["gnf"] = "@function.outer",
              ["gnc"] = "@class.outer",
              ["gns"] = "@scope",
              ["gnb"] = "@block.outer",
            },
            goto_previous_start = {
              ["gNF"] = "@function.outer",
              ["gNC"] = "@class.outer",
              ["gNS"] = "@scope",
              ["gNB"] = "@block.outer",
            },
            goto_previous_end = {
              ["gNf"] = "@function.outer",
              ["gNc"] = "@class.outer",
              ["gNs"] = "@scope",
              ["gNb"] = "@block.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            -- goto_next = {
              -- ["]d"] = "@conditional.outer",
            -- },
            -- goto_previous = {
              -- ["[d"] = "@conditional.outer",
            -- }
          },
        },
      }
      vim.cmd [[set foldmethod=expr]]
      vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
      vim.cmd [[set nofoldenable]]
    end
  },
  'nvim-treesitter/nvim-treesitter-textobjects',

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
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

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

  {
    'j-hui/fidget.nvim', lazy = true, event = 'VimEnter',
    config = true,
  },

  {
    'folke/neodev.nvim', lazy = true,
    config = {
      setup_jsonls = false,
      lspconfig = false,
    },
  },

  -- {
  --   "folke/trouble.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = true, lazy = true
  -- },

  -- {
  --   'jose-elias-alvarez/typescript.nvim', lazy = true,
  -- },
  -- {
  --   'jose-elias-alvarez/null-ls.nvim', lazy = true, event = 'VimEnter',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function () 
  --     local null_ls = require("null-ls")
  --
  --     null_ls.setup({
  --       sources = {
  --         null_ls.builtins.formatting.stylua,
  --         --- null_ls.builtins.diagnostics.eslint,
  --         null_ls.builtins.completion.spell,
  --         null_ls.builtins.code_actions.gitsigns,
  --         require("typescript.extensions.null-ls.code-actions"),
  --       },
  --     })
  --
  --   end
  -- },
  --
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
      vim.g.neo_tree_remove_legacy_commands = 1

      local events = require("neo-tree.events")

      local function on_file_move (args)
        vim.pretty_print(args)
        local ts_clients = vim.lsp.get_active_clients({ name = "tsserver" })
        for _, ts_client in ipairs(ts_clients) do
          ts_client.request("workspace/executeCommand", {
            command = "_typescript.applyRenameFile",
            arguments = {
              {
                sourceUri = vim.uri_from_fname(args.source),
                targetUri = vim.uri_from_fname(args.destination),
              },
            },
          })
        end
      end

      require('neo-tree').setup({
        filesystem = {
          hijack_netrw_behavior = 'open_current',
          window = {
            mappings = {
              ["o"] = "system_open",
              ["<C-c>"] = "clear_filter",
            },
          },
          commands = {
            system_open = function (state)
              local node = state.tree:get_node()
              local path = node:get_id()
              local platform = require('util.platform')

              if platform == 'Darwin' then
                vim.api.nvim_command(string.format("silent !open -g '%s'", path))
              elseif platform == 'Linux' then
                vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
              end
            end
          }
        },
        event_handlers = {
          {
            event = events.FILE_MOVED,
            handler = on_file_move,
          },
          {
            event = events.FILE_RENAMED,
            handler = on_file_move,
          },
        },
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
    lazy = true, event = 'VimEnter', config = true,
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

  -- autopairs
  -- {
  --   'windwp/nvim-autopairs', lazy = true, event = 'VimEnter',
  --   config = function ()
  --     local npairs = require("nvim-autopairs")
  --     local Rule = require('nvim-autopairs.rule')
  --     npairs.setup({
  --       check_ts = true,
  --       ts_config = {
  --         lua = {'string'},-- it will not add a pair on that treesitter node
  --         javascript = {'template_string'},
  --         java = false,-- don't check treesitter on java
  --       }
  --     })
  --
  --     local ts_conds = require('nvim-autopairs.ts-conds')
  --
  --     npairs.add_rules({
  --       Rule("%", "%", "lua")
  --         :with_pair(ts_conds.is_ts_node({'string','comment'})),
  --       Rule("$", "$", "lua")
  --         :with_pair(ts_conds.is_not_ts_node({'function'}))
  --     })
  --
  --   end,
  -- },

  -- motion %
  { 'andymass/vim-matchup' },

  -- {
  --   'kylechui/nvim-surround', tag = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   event = 'VimEnter', lazy = true, config = true,
  -- },

  -- {
  --   'ggandor/leap.nvim',
  --   event = 'VimEnter', lazy = true,
  --   dependencies = { 'tpope/vim-repeat' },
  --   config = function ()
  --     require('leap').add_default_mappings()
  --   end,
  -- },

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

