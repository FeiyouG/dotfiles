local plugin = {}

-- Plugin name
table.insert(plugin, "williamboman/nvim-lsp-installer")

-- plugin configuration
plugin.config = function()
  local nvim_lsp_installer = require("nvim-lsp-installer")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- MARK: update capability for nvim-cmp
  local has_nvim_cmp, nvim_cmp = pcall(require, 'cmp_nvim_lsp')
  if has_nvim_cmp then
    capabilities = nvim_cmp.update_capabilities(capabilities)
  end


  ---- MARK: Making sure some lsp are all always installed ----
  local servers = {
    "ltex",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "jdtls",
    "jsonls",
    "pyright",
  }

  for _, name in pairs(servers) do
    local server_found, server = nvim_lsp_installer.get_server(name)
    if server_found and not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end


  ---- MARK: Setup the servers ----

  -- List of servers that has a custom behaviors in "custom_servers" folder
  local custom_servers = require("plugin/lsp/custom_servers")

  nvim_lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      -- on_attach = on_attach,
    }

    -- Load custom server settings from "custom_servers" folder
    for _ , custom_server in ipairs(custom_servers) do
      -- require("config/lsp/custom_servers/" .. name)(opts)
      custom_server(opts)
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
  end)

end

return plugin
