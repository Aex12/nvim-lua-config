local servers_ok, servers = pcall(require, 'lsp.servers')
local mason_ok, mason = pcall(require, "mason")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

if not (servers_ok and mason_ok and mason_lspconfig_ok) then
  return
end

mason.setup()
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})
