return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'c',
          'ini',
          'vim',
          'dockerfile',
          'diff',
          'gitcommit',
          'gitignore',
          'bash',
          'perl',
          'lua',
          'python',
          'yaml',
          'json',
          'jsdoc',
          'javascript',
          'typescript',
          'tsx',
          'css',
          'regex',
          'prisma',
          'sql',
          'html',
          'markdown',
          'markdown_inline',
          'php',
          'go',
          'dot',
          'rust',
          'smali',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
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
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ['gnF'] = '@function.outer',
              ['gnC'] = '@class.outer',
              ['gnS'] = '@scope',
              ['gnB'] = '@block.outer',
            },
            goto_next_end = {
              ['gnf'] = '@function.outer',
              ['gnc'] = '@class.outer',
              ['gns'] = '@scope',
              ['gnb'] = '@block.outer',
            },
            goto_previous_start = {
              ['gNF'] = '@function.outer',
              ['gNC'] = '@class.outer',
              ['gNS'] = '@scope',
              ['gNB'] = '@block.outer',
            },
            goto_previous_end = {
              ['gNf'] = '@function.outer',
              ['gNc'] = '@class.outer',
              ['gNs'] = '@scope',
              ['gNb'] = '@block.outer',
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
      })
      vim.cmd([[set foldmethod=expr]])
      vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
      vim.cmd([[set nofoldenable]])
    end,
  },
  -- motion %
  'andymass/vim-matchup',
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VimEnter',
    lazy = true,
    config = function()
      vim.cmd([[highlight IblIndent guifg=#2A2A37 gui=nocombine]])
      vim.cmd([[highlight IblScope guifg=#3f3f4b gui=nocombine]])
      require('ibl').setup({
        indent = { char = '▏' },
        -- show_current_context = true,
        -- show_current_context_start = false,
      })
    end,
  },
}
