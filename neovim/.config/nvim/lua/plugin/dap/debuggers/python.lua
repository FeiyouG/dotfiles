return {
  adapters = {
    type = "executable",
    command = Utils.path.python.debugby_exec,
    args = { "-m", "debugpy.adapter" }
  },

  configurations = {
    {
      -- The first three options are required by nvim-dap
      type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch',
      name = "Launch file",

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      program = "${file}", -- This configuration will launch the current file if used.
      pythonPath = function()
        local executable = os.getenv("VIRTUAL_ENV") or os.getenv("VIRTUALENVWRAPPER_PYTHON")
        if not executable then
          Utils.notify.info("nvim-dap", "python executable not found")
        end
        return executable
      end
    },
  }
}
