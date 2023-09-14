local servers = {
  'cssls',
  'html',
  'tsserver',
  'eslint',
  'pyright',
  'bashls',
  'jsonls',
  'yamlls',
  'rust_analyzer',
  'prismals',
  {
    name = 'lua_ls',
    setup = {
      before_init = function (...)
        return require('neodev.lsp').before_init(...)
      end
    },
  },
}

return servers
