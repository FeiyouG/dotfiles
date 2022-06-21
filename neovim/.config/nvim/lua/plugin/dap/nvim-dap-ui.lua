return {
  "rcarriga/nvim-dap-ui",

  config = function()
    local dapui = require("dapui")
    dapui.setup({
      icons = { expanded = "−", collapsed = "+" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has("nvim-0.7"),
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 10,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
      }
    })
  end,

  defer = function()
    -- MARK: Register and add to command_center
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end
    local noremap = { noremap = true }

    local dapui = require("dapui")

    command_center.add({
      {
        description = "Open floating window for dap",
        cmd = dapui.float_element,
        keybindings = { "n", "<leader>D", noremap },
        category = "dap"
      }
    })
  end
}
