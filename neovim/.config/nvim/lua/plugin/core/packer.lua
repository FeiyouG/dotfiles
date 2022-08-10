return {
  'wbthomason/packer.nvim',

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
        cmd = packer.profile_output
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
