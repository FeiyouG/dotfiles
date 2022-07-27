return {
  'rcarriga/nvim-notify',

  config = function()

    local notify = require("notify")
    notify.setup({
      level = vim.log.levels.INFO,
      background_colour = "Normal",
      stages = "fade_in_slide_out",
      minimum_width = 10,
      timeout = 5000
    })
    vim.notify = notify
  end,

  defer = function()
    local utils = require("utils")
    local telescope = utils.fn.require("telescope", "Tries to load nvim-notify as telescope extension")
    if telescope then
      telescope.load_extension("notify")
    end
  end,

  commands = {
    {
      description = "Show notification history",
      cmd = "<CMD>Telescope notify<CR>"
    }, {
      description = "Dismiss notifcations",
      cmd = require("notify").dismiss
    }
  }
}
