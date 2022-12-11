require("utils.datastructures")

local M = vim.tbl_extend("keep", require("utils.fn"), {
	system = require("utils.system"),
	path = require("utils.path"),
	notify = require("utils.notify"),
	lsp = require("utils.lsp"),
	str = require("utils.str"),

	ft = require("utils.ft"),
	icons = require("utils.icons"),
	highlight = require("utils.highlight"),
	keymap = require("utils.keymap"),

  state = require("utils.state")
})

return M
