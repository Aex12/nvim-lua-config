local servers_ok, servers = pcall(require, 'lsp.servers')
local mason_ok, mason = pcall(require, 'mason')
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')

if not (servers_ok and mason_ok and mason_lspconfig_ok) then
  return
end

mason.setup()

local ensure_installed = {}

for _, v in ipairs(servers) do
  local vtype = type(v)
  if vtype == 'table' then
    table.insert(ensure_installed, v.name)
  elseif vtype == 'string' then
    table.insert(ensure_installed, v)
  end
end

mason_lspconfig.setup({
  ensure_installed = ensure_installed,
  automatic_installation = true,
})
