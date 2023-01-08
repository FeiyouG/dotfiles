return {
  nvim_lspconfig = {
    ltex = require("plugin.lsp.servers.ltex"),
    sumneko_lua = require("plugin.lsp.servers.sumneko_lua"),
    gopls = require("plugin.lsp.servers.gopls"),
    beancount = require("plugin.lsp.servers.beancount"),
    lemminx = require("plugin.lsp.servers.lemminx"),
    pylsp = require("plugin.lsp.servers.pylsp"),

    ocamllsp = {},
    tsserver = {},
    vimls = {},
    bashls = {},
    html = {},
    clangd = {},
    jsonls = {},

    -- test = {},
  },

  jdtls = {
    java = require("plugin.lsp.servers.jdtls"),
  },
}
