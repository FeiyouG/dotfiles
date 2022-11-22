return {
  nvim_lspconfig = {
    ltex = require("plugin.lsp.servers.ltex"),
    sumneko_lua = require("plugin.lsp.servers.sumneko_lua"),
    gopls = require("plugin.lsp.servers.gopls"),
    beancount = require("plugin.lsp.servers.beancount"),
    tsserver = {},
    vimls = {},
    pyright = {},
    html = {},
    clangd = {},
    jsonls = {},
    lemminx = require("plugin.lsp.servers.lemminx"),

    test = {},
  },

  jdtls = {
    java = require("plugin.lsp.servers.jdtls"),
  },
}
