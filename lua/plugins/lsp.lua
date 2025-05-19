return {
  {
    'j-hui/fidget.nvim',
    lazy = true,
    event = 'VimEnter',
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable('rust_analyzer')
    end,
  },
  {
    'creativenull/efmls-configs-nvim',
    version = 'v1.x.x',
    dependencies = { 'neovim/nvim-lspconfig' },
    -- lazy = true, event = 'VimEnter',
    config = function()
      local shellcheck = require('efmls-configs.linters.shellcheck')
      local stylua = require('efmls-configs.formatters.stylua')
      local selene = require('efmls-configs.linters.selene')

      local languages = {
        bash = { shellcheck },
        sh = { shellcheck },
        lua = { stylua, selene },
      }

      local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
          rootMarkers = { '.git/' },
          languages = languages,
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      }

      vim.lsp.enable('efm')
      vim.lsp.config('efm', efmls_config)
    end,
  },
}
