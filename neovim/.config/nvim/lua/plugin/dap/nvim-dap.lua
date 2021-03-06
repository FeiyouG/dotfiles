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

  defer = function()
    -- MARK: Register and add to command_center
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end
    local noremap = { noremap = true }

    local dap = require("dap")
    local has_dapui, dapui = pcall(require, "dapui")

    command_center.add({
      {
        descriptionL = "Search all debugger",
        cmd = "<CMD>Telescope command_center category=dap<CR>",
        keybindings = { "n", "<leader>d", noremap },
        mode = command_center.mode.REGISTER_ONLY,
      }, {
        description = "Toggle Breakpoint",
        cmd = dap.toggle_breakpoint,
        keybindings = { "n", "<leader>db", noremap },
        category = "dap",
      }, {
        description = "Start debuging",
        cmd = function()
          dap.continue()
          -- if has_dapui then
          --   dapui.open()
          -- end
        end,
        keybindings = { "n", "<leader>ds", noremap },
        category = "dap",
      }, {
        description = "End debuging",
        cmd = function()
          dap.terminate()
          -- if has_dapui then
          --   dapui.close()
          -- end
        end,
        keybindings = { "n", "<leader>dc", noremap },
        category = "dap",
      }, {
        description = "Step over",
        cmd = dap.step_over,
        keybindings = { "n", "<leader>dn", noremap },
        category = "dap",
      }, {
        description = "Step into",
        cmd = dap.step_into,
        keybindings = { "n", "<leader>di", noremap },
        category = "dap",
      }, {
        description = "Step back",
        cmd = dap.step_back,
        keybindings = { "n", "<leader>dp", noremap },
        category = "dap",
      }, {
        description = "Step out",
        cmd = dap.step_out,
        keybindings = { "n", "<leader>do", noremap },
        category = "dap",
      }

    })

  end
}
