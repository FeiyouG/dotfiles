return {
  "wbthomason/packer.nvim",

  commands = function()
    local packer = require("packer")
    return {
      {
        description = "Sync plugins",
        cmd = packer.sync,
        cat = "packer",
      },
      {
        description = "Compile plugins",
        cmd = packer.compile,
        cat = "packer",
      },
      {
        description = "Show plugins startup time",
        cmd = packer.profile_output,
        cat = "packer",
      },
      {
        description = "Show plugins status",
        cmd = packer.status,
        cat = "packer",
      },
      {
        description = "Install missing plugins",
        cmd = packer.install,
        cat = "packer",
      },
      {
        description = "Save plugin snapshot",
        cmd = function()
          packer.snapshot("snapshot" .. vim.fn.strftime("%Y%m%d%H%M%S"))
          Utils.notify.info("Packer", "snapshot" .. vim.fn.strftime("%Y%m%d%H%M%S") .. " is created")
        end,
        cat = "packer",
      },
      {
        description = "Load latest plugin snapshot",
        cmd = function()
          local snapshots = Utils.path.glob(Utils.path.packer.snapshot_path, "*")

          if #snapshots == 0 then
            Utils.notify.warn("Packer", "No snapshot found")
          end

          snapshots:sort(function(a, b)
            return a > b
          end)
          packer.rollback(snapshots[1])
          Utils.notify.info("Packer", snapshots[1] .. " is loaded")
        end,
        cat = "packer",
      },
    }
  end,
}
