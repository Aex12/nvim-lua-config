pcall(require, 'lsp.cmp')
pcall(require, 'lsp.mason')

local servers_ok, servers = pcall(require, 'lsp.servers')
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
local keymap_ok, keymap = pcall(require, 'keymap.keymap')

if not (servers_ok and lspconfig_ok and keymap_ok) then
  return
end

vim.diagnostic.config({
  virtual_text = false,
})

------------- LSP --------------
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- vim.api.nvim_create_autocmd({'CursorHold'}, {
    -- pattern = '*',
    -- callback = vim.diagnostic.open_float
  -- })

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local lsp_signature_ok, lsp_signature = pcall(require, 'lsp_signature')
  if lsp_signature_ok then
    lsp_signature.on_attach({
      bind = false,
      floating_window = false,
    }, bufnr)
  end

  -- Mappings.
  keymap.lsp_on_attach(client, bufnr)
end

-- Set up lspconfig.
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp_ok
  and cmp_nvim_lsp.default_capabilities(client_capabilities)
  or client_capabilities

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

opts = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities
}

for _, server in pairs(servers) do
  lspconfig[server].setup(opts)
end
