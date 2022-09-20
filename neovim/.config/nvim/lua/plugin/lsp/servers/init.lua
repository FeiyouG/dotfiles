return {
  ltex = require("plugin.lsp.servers.ltex"),
  sumneko_lua = require("plugin.lsp.servers.sumneko_lua"),
  gopls = require("plugin.lsp.servers.gopls"),
  tsserver = {},
  vimls = {},
  -- jdtls = {},    -- setup through nvim-jdtls
  pyright = {},
  html = {},
  clangd = {},
  jsonls = {},
  beancount = require("plugin.lsp.servers.beancount"),

  test = {}
}
