return {
  "mfussenegger/nvim-dap",

  config = function()
    -- MARK: Configure individual debuggers
    local dap = require("dap")
    local debuggers = require("plugin/dap/debuggers")

    for debugger, debug_config in pairs(debuggers) do
      if debug_config.adapters then
        dap.adapters[debugger] = debug_config.adapters
      end

      if debug_config.configurations then
        dap.configurations[debugger] = debug_config.configurations
      end
    end


    local has_dapui, dapui = pcall(require, "dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      if has_dapui then dapui.open() end
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      if has_dapui then dapui.close() end
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      if has_dapui then dapui.close() end
    end
  end,

  commands = function()
    local dap = require("dap")
    local keymap = Utils.constants.keymap

    return {
      {
        descriptionL = "Search all debugger",
        cmd = "<CMD>Telescope command_center category=dap<CR>",
        keybindings = { "n", "<leader>d", keymap.noremap },
        mode = keymap.cc_mode.REGISTER_ONLY,
      }, {
        description = "Toggle Breakpoint",
        cmd = dap.toggle_breakpoint,
        keybindings = { "n", "<leader>db", keymap.noremap },
        category = "dap",
      }, {
        description = "Start debuging",
        cmd = dap.continue,
        keybindings = { "n", "<leader>ds", keymap.noremap },
        category = "dap",
      }, {
        description = "End debuging",
        cmd = dap.terminate,
        keybindings = { "n", "<leader>dc", keymap.noremap },
        category = "dap",
      }, {
        description = "Step over",
        cmd = dap.step_over,
        keybindings = { "n", "<leader>dn", keymap.noremap },
        category = "dap",
      }, {
        description = "Step into",
        cmd = dap.step_into,
        keybindings = { "n", "<leader>di", keymap.noremap },
        category = "dap",
      }, {
        description = "Step back",
        cmd = dap.step_back,
        keybindings = { "n", "<leader>dp", keymap.noremap },
        category = "dap",
      }, {
        description = "Step out",
        cmd = dap.step_out,
        keybindings = { "n", "<leader>do", keymap.noremap },
        category = "dap",
      }
    }
  end,
}
