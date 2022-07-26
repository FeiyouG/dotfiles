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
    local custom_modes = require("plugin/submodes/modes")

    -- Create all submodes
    for _, mode_init_func in pairs(custom_modes) do
      mode_init_func()
    end
  end
}
