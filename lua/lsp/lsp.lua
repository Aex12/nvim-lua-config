pcall(require, 'lsp.cmp')
pcall(require, 'lsp.mason')

local servers_ok, servers = pcall(require, 'lsp.servers')
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')

if not (servers_ok and lspconfig_ok) then
  return
end

------------- LSP --------------
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_client, bufnr)
  -- vim.api.nvim_create_autocmd({'CursorHold'}, {
    -- pattern = '*',
    -- callback = vim.diagnostic.open_float
  -- })

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
  if lsp_signature_ok then
    lsp_signature.on_attach({
      bind = false,
      floating_window = false,
    }, bufnr)
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'cd', '<cmd>Lspsaga peek_definition<CR>', bufopts)
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', bufopts)
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'ge', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', 'gE', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-e>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', ":CodeActionMenu<CR>", bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  local telescope_ok, telescope = pcall(require, 'telescope.builtin')

  if telescope_ok then
    local responsiveTelescope_ok, responsiveTelescope = pcall(require, 'responsive-telescope')
    if not (responsiveTelescope_ok) then
      responsiveTelescope = function (builtin) builtin() end
    end
    vim.keymap.set('n', 'gd', responsiveTelescope(telescope.lsp_definitions), bufopts)
    vim.keymap.set('n', 'gr', responsiveTelescope(telescope.lsp_references), bufopts)
  else
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  end
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
