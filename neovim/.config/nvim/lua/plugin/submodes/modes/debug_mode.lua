return {
  name = "debug",
  icon = Utils.icons.debug.debug,
  key = "d",
  color = "pink",
  mode = { "n", "x" },

  commands = function()
    local keymap = Utils.keymap
    local commands = {}


    local nvim_dap = Utils.require("dap")
    if nvim_dap then
      vim.list_extend(commands, {
        {
          desc = "Toggle Breakpoint",
          cmd = nvim_dap.toggle_breakpoint,
          keys = { "n", "b", keymap.noremap },
          cat = "dap",
        }, {
          desc = "Toggle Breakpoint with condition",
          cmd = function()
            nvim_dap.continue(vim.fn.input('Breakpoint condition: '))
          end,
          keys = { "n", "<leader>B", keymap.noremap },
          cat = "dap",
        }, {
          desc = "Start/continue debuging",
          cmd = nvim_dap.continue,
          keys = { "n", "<leader>c", keymap.noremap },
          cat = "dap",
        }, {
          desc = "End debuging",
          cmd = nvim_dap.terminate,
          keys = { "n", "<leader>d", keymap.noremap },
          cat = "dap",
        }, {
          desc = "Step into",
          cmd = nvim_dap.step_into,
          keys = { "n", "<c-i>", keymap.noremap },
          cat = "dap",
        }, {
          desc = "Step over",
          cmd = nvim_dap.step_over,
          keys = { "n", "<c-n>", keymap.noremap },
          cat = "dap",
        }, {
          desc = "Step back",
          cmd = nvim_dap.step_back,
          keys = { "n", "<c-p>", keymap.noremap },
          cat = "dap",
        }, {
          desc = "Step out",
          cmd = nvim_dap.step_out,
          keys = { "n", "<c-o>", keymap.noremap },
          cat = "dap",
        },
      })
    end

    local dap_ui = Utils.require("dapui")
    if dap_ui then
      vim.list_extend(commands, {
        {
          desc = "Evaluate word under cursor",
          cmd = dap_ui.eval,
          keys = { "n", "K", keymap.noremap },
          cat = "dap",
        }
      })
    end

    --   descL = "Search all debugger",
    --   cmd = "<CMD>Telescope command_center cat=dap<CR>",
    --   keys = { "n", "<leader>d", keymap.noremap },
    --   mode = keymap.cc_mode.REGISTER_ONLY,
    -- }, {

    return commands
  end
}
