local M = {
  system = require("utils.system"),
  path = require("utils.path"),
  notify = require("utils.notify"),
  lsp = require("utils.lsp"),
  str = require("utils.str"),

  states = require("utils.states"),
  icons = require("utils.icons"),
  keymap = require("utils.keymap"),

  require = require("utils.fn").require,
  load = require("utils.fn").load,
  add_commands = require("utils.fn").add_commands,
}

return M
