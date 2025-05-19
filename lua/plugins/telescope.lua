return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        layout_strategy = 'flex',
        layout_config = {
          width = 0.99999,
          height = 0.99999,
          horizontal = {
            preview_width = 0.6,
          },
        },
      },
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
}
