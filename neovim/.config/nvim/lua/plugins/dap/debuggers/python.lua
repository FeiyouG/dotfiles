local python = require("settings.lang").python

return {
  adapters = {
    type = "executable",
    command = python.debugby_exec,
    args = { "-m", "debugpy.adapter" },
  },

  configurations = {
    {
      -- The first three options are required by nvim-dap
      type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = "launch",
      name = "Launch file",

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = function()
        if python.executable then
          return python.executable
        end
        vim.notify("nvim-dap", "python executable not found")
        return nil
      end,
    },
  },
}
