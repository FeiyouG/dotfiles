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
    Utils.states.filetype.quit_on_q:add("notify")
  end,

  commands = {
    {
      desc = "Show notification history",
      cmd = "<CMD>Telescope notify<CR>"
    }, {
      desc = "Dismiss notifcations",
      cmd = require("notify").dismiss
    -- }, {
    --   desc = "Quit notify",
    --   cmd = function()
    --     local bf = vim.api.nvim_get_current_buf()
    --     local filetype = vim.api.nvim_buf_get_option(bf, "filetype")
    --     if filetype == "notify" then
    --       vim.cmd("quit!")
    --     end
    --   end,
    --   keys = { "n", "q" },
    --   -- mode = Utils.constants.keymap.cc_mode.SET
    }
  }
}
