return {
  'anuvyklack/hydra.nvim',

  require = {
    -- For git mode
    "FeiyouG/command_center",
    'lewis6991/gitsigns.nvim',
    "sindrets/diffview.nvim",
    'TimUntersberger/neogit',
  },

  defer = function()
    local modes = require("plugin/submodes/modes")

    -- Create all submodes
    for _, submode in ipairs(modes) do
      submode()
    end
  end
}
