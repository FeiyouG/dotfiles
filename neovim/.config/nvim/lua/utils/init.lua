local M = require("utils.fn")

return vim.tbl_extend("force", M, {
  system = require("utils.system"),
  path = require("utils.path"),
  notify = require("utils.notify"),
  lsp = require("utils.lsp"),
  str = require("utils.str"),

  states = require("utils.states"),
  icons = require("utils.icons"),
  keymap = require("utils.keymap")
})
