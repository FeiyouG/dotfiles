return {
  system = require("utils.system"),
  path = require("utils.path"),
  notify = require("utils.notify"),
  lsp = require("utils.lsp"),
  str = require("utils.str"),

  ft = require("utils.ft"),
  icons = require("utils.icons"),
  highlight = require("utils.highlight"),
  keymap = require("utils.keymap"),

  P = require("utils.fn").P,
  require = require("utils.fn").require,
  load = require("utils.fn").load,
  add_commands = require("utils.fn").add_commands,
  is_callable = require("utils.fn").is_callable,
  find_root = require("utils.fn").find_root,
}
