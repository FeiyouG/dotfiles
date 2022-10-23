return {
  "mfussenegger/nvim-dap",

  config = function()
    -- MARK: Configure individual debuggers
    local dap = require("dap")
    local debuggers = require("plugin/dap/debuggers")

    for debugger, config in pairs(debuggers) do
      dap.adapters[debugger] = config.adapters
      dap.configurations[debugger] = config.configurations
    end


    -- Customize nvim-dap
    vim.fn.sign_define(
      "DapBreakpoint", {
      text = Utils.icons.debug.breakpoint,
      texthl = "DiffChanged",
      linehl = "DiffChange",
      numhl = "DiffChange"
    }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition", {
      text = Utils.icons.debug.breakpoint_conditional,
      texthl = "DiffChanged",
      linehl = "DiffChange",
      numhl = "DiffChange"
    }
    )

    vim.fn.sign_define(
      "DapBreakpointRejected", {
      text = Utils.icons.debug.breakpoint_rejected,
      texthl = "DiffRemoved",
      linehl = "DiffDelete",
      numhl = "DiffDelete"
    }
    )

    vim.fn.sign_define(
      "DapLogPoint", {
      text = Utils.icons.debug.logpoint,
      texthl = "DapBreakpointCondition",
      linehl = "DiffChange",
      numhl = "DiffChange"
    }
    )

    vim.fn.sign_define(
      "DapStopped", {
      text = Utils.icons.debug.stopped,
      texthl = "DiffAdded",
      linehl = "DiffAdd",
      numhl = "DiffAdd"
    }
    )
  end,

}
