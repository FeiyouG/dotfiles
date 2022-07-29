local get_cc_mode = function()
  local cc = require("Utils.fn").require("command_center", "utils.fn.keymap.cc_mode is initialized to an empty table")
  if cc then return cc.mode end
  return {}
end

return {
  noremap = { noremap = true },
  silent = { silent = true },
  nowait = { nowait = true },
  expr = { expr = true },

  silent_noremap = { noremap = true, silent = true },
  noremap_expr = { noremap = true, expr = true },
  nowait_expr = { nowait = true, expr = true },

  cc_mode = get_cc_mode()
}
