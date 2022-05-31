return {
  "mfussenegger/nvim-dap",

  config = function()
    -- MARK: Configure individual debuggers
    local dap = require("dap")
    local debuggers = require("plugin/dap/debuggers")

    for debugger, debug_config in pairs(debuggers) do
      dap.adapters[debugger] = debug_config.adapters
      dap.configurations[debugger] = debug_config.configurations
    end
  end,

  defer = function()
    -- MARK: Register and add to command_center
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    local noremap = { noremap = true }
    local dap = require("dap")

    command_center.add({
      {
        descriptionL = "",
        cmd = "<CMD>Telescope command_center category=dap",
        keybindings = { "n", "<leader>b", noremap },
      },
      {
        description = "Toggle Breakpoint",
        cmd = dap.toggle_breakpoint,
        keybindings = { "n", "<leader>bd", noremap },
        category = "dap",
      }
    })

  end
}
