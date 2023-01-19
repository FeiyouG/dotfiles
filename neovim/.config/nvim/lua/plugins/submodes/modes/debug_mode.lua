local style = require("settings.style")
local fn = require("settings.fn")

return {
  name = "debug",
  icon = style.icons.debug.debug,
  key = "d",
  color = "pink",
  mode = { "n", "x" },

  commands = function()
    local commands = {}

    local nvim_dap = fn.require("dap")
    if nvim_dap then
      vim.list_extend(commands, {
        {
          desc = "Toggle Breakpoint",
          cmd = nvim_dap.toggle_breakpoint,
          keys = { "n", "<leader>b" },
        },
        {
          desc = "Toggle Breakpoint with condition",
          cmd = function()
            nvim_dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
          end,
          keys = { "n", "<leader>B" },
        },
        {
          desc = "Start/continue debuging",
          cmd = nvim_dap.continue,
          keys = { "n", "<leader>c" },
        },
        {
          desc = "End debuging",
          cmd = nvim_dap.terminate,
          keys = { "n", "<leader>d" },
        },
        {
          desc = "Step into",
          cmd = nvim_dap.step_into,
          keys = { "n", "<c-i>" },
        },
        {
          desc = "Step over",
          cmd = nvim_dap.step_over,
          keys = { "n", "<c-n>" },
        },
        {
          desc = "Step back",
          cmd = nvim_dap.step_back,
          keys = { "n", "<c-p>" },
          cat = "dap",
        },
        {
          desc = "Step out",
          cmd = nvim_dap.step_out,
          keys = { "n", "<c-o>" },
        },
      })
    end

    local dap_ui = fn.require("dapui")
    if dap_ui then
      vim.list_extend(commands, {
        {
          desc = "Evaluate word under cursor",
          cmd = dap_ui.eval,
          keys = { "n", "K" },
        },
      })
    end

    if fn.require("telescope.dap") then
      vim.list_extend(commands, {
        {
          desc = "List all breakpoints",
          cmd = "<CMD>Telescope dap list_breakpoints",
          keys = { "n", "<leader>fb" },
        },
      })
    end

    return commands
  end,
}
