return {
  'rcarriga/nvim-notify',

  config = function()

    local notify = require("notify")
    notify.setup({
      level = vim.log.levels.INFO,
      background_colour = "Normal",
      stages = "fade_in_slide_out",
      minimum_width = 20,
      timeout = 5000
    })
    vim.notify = notify
  end,

  defer = function()
    local telescope = Utils.fn.require("telescope", "Tries to load nvim-notify as telescope extension")
    if telescope then
      telescope.load_extension("notify")
    end

    -- Quit notify when pressing q
    Utils.state.filetype.quit_on_q:add("notify")
  end,

  commands = function()
    return {
    {
      desc = "Show notification history",
      cmd = "<CMD>Telescope notify<CR>"
    }, {
      desc = "Dismiss notifcations",
      cmd = require("notify").dismiss
    }
  }

  end
}
