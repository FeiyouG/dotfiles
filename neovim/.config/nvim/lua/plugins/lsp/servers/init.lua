return {
  nvim_lspconfig = {
    sumneko_lua = require("plugins.lsp.servers.sumneko_lua"),
    gopls = require("plugins.lsp.servers.gopls"),
    beancount = require("plugins.lsp.servers.beancount"),
    lemminx = require("plugins.lsp.servers.lemminx"),
    pylsp = require("plugins.lsp.servers.pylsp"),
    ltex = require("plugins.lsp.servers.ltex"),

    texlab = {},
    ocamllsp = {},
    tsserver = {},
    vimls = {},
    bashls = {},
    html = {},
    clangd = {},
    jsonls = {},

    -- test = {},
  },

  jdtls = require("plugins.lsp.servers.jdtls"),
}
