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

    local hydra = require("hydra")
    local command_center = Utils.fn.require("command_center",
      "submode requires command_center to register keybindings")

    -- Create all submodes
    for _, submode in ipairs(modes) do
      submode(hydra, command_center)
    end
  end
}
