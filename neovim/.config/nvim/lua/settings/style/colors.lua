local fn = require("settings.fn")

local colors = fn.require("onenord.colors")

if not colors then
  return nil
end

local M = {}

M.lualine = {
  diff = {
    added = {
      fg = colors.diff_add,
      bg = colors.active,
    },
    dified = {
      fg = colors.diff_change,
      bg = colors.active,
    },
    reved = {
      fg = colors.dff_remove,
      bg = colors.active,
    },
  },
}

return M
