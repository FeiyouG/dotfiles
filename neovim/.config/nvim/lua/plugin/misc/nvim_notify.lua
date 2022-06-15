return {
  'rcarriga/nvim-notify',

  config = function()
    vim.notify = require("notify")
  end,

  defer = function()
    local has_telescope, telescope = pcall(require, "telescope")
    local has_command_center, command_center = pcall(require, "command_center")

    if not has_command_center or not has_telescope then return end

    telescope.load_extension("notify")

    command_center.add({
      {
        description = "Show notification history",
        cmd = "<CMD>Telescope notify<CR>"
      }
    })

  end
}
