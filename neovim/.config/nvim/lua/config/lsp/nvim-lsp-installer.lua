local lsp_installer = require("nvim-lsp-installer")


-- MARK: nvim-cmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


---- MARK: Making sure desired lsp are all installed ----
local servers = {
  "ltex",
  "sumneko_lua",
  "tsserver",
  "vimls",
  "jdtls"
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end


-- MARK: List of servers that has a custom behaviors in "custom_servers" folder
local custom_servers = {
  "sumneko_lua",
  "ltex",
}


---- MARK: Setup the servers ----
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    -- on_attach = on_attach,
  }

  -- Load custom server settings from "custom_servers" folder
  for _, name in pairs(custom_servers) do
    require("config/lsp/custom_servers/" .. name)(opts)
  end

  -- This setup() function will take the provided server configuration and decorate it with the necessary properties
  -- before passing it onwards to lspconfig.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
