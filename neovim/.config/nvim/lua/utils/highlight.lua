local colors, error = pcall(require, "onenord.colors")

if not colors then
  print(error)
  return {}
end

local M = {
  colors = require("onenord.colors")
}

M.lualine = {
  diff = {
    added = {
      fg = M.colors.diff_add,
      bg = M.colors.active,
    },
    modified = {
      fg = M.colors.diff_change,
      bg = M.colors.active,
    },
    removed = {
      fg = M.colors.dff_remove,
      bg = M.colors.active,
    },
  }
}

return M
