return {
	nvim_lspconfig = {
		lua_ls = require("plugins.lsp.servers.lua_ls"),
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
		racket_langserver = {},

		-- test = {},
	},

	jdtls = require("plugins.lsp.servers.jdtls"),
}
