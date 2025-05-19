return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      window = {
        mappings = {
          ['<C-c>'] = 'clear_filter',
        },
      },
    },
    window = {
      mappings = {
        ['<C-b>'] = 'close_window',
        ['Wf'] = function()
          vim.api.nvim_exec('Neotree show filesystem current', false)
        end,
        ['Wb'] = function()
          vim.api.nvim_exec('Neotree show buffers current', false)
        end,
        ['Wg'] = function()
          vim.api.nvim_exec('Neotree show git_status current', false)
        end,
      },
    },
  },
}
