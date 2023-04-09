return {
  "rebelot/heirline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "rmehri01/onenord.nvim",
    "SmiteshP/nvim-navic",
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local heirline = require("heirline")
    local conditions = require("heirline.conditions")

    local statusline = require("plugins.style.heirline.statusline")
    local statuscolumn = require("plugins.style.heirline.statuscolumn")
    local winbar = require("plugins.style.heirline.winbar")


    heirline.setup({
      statusline = statusline,
      statuscolumn = statuscolumn,
    })
  end,
}
