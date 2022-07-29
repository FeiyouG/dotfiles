return {
  'wbthomason/packer.nvim',

  config = function()
    local packer = require("packer")
    local packer_util = require("packer.util")

    packer.reset()
    packer.init({
      profile = {
        enable = true,
        threshold = 0,
      },

      display = {
        open_fn = packer_util.float,
      }
    })
  end,

  commands = function()
    local packer = require("packer")
    return {
      {
        description = "Sync plugins",
        cmd = packer.sync,
      }, {
        description = "Compile plugins",
        cmd = packer.compile
      }, {
        description = "Show plugins startup time",
        cmd = packer.profile
      }, {
        description = "Show plugins status",
        cmd = packer.status
      }, {
        description = "Install missing plugins",
        cmd = packer.install
      }
    }
  end

}
