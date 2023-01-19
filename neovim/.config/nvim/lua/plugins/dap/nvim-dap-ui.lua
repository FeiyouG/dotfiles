return {
  "rcarriga/nvim-dap-ui",

  dependencies = {
    "mfussenegger/nvim-dap",
  },

  config = function()
    local dapui = require("dapui")
    local style = require("settings.style")

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
      expand_lines = true,

      layouts = {
        {
          elements = {
            "watches",
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
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

      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = " ",
          play = " ",
          step_into = " ",
          step_over = " ",
          step_out = " ",
          step_back = " ",
          run_last = "↻ ",
          terminate = " ",
        },
      },

      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = style.border.rounded,
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      },
    })

    -- MARK: Helper functions
    local debug_win = nil
    local debug_tab = nil
    local debug_tabnr = nil

    local function open_in_tab()
      if debug_win and vim.api.nvim_win_is_valid(debug_win) then
        vim.api.nvim_set_current_win(debug_win)
        return
      end

      vim.cmd("tabedit %")
      debug_win = vim.fn.win_getid()
      debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
      debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

      dapui.open()
    end

    local function close_tab()
      dapui.close()

      if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
        vim.api.nvim_exec("tabclose " .. debug_tabnr, false)
      end

      debug_win = nil
      debug_tab = nil
      debug_tabnr = nil
    end

    -- MARK: Automatically open and close dapui, if installed
    local dap = require("dap")
    if dap then
      dap.listeners.after.event_initialized["dapui_config"] = function()
        open_in_tab()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        close_tab()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        close_tab()
      end
    end
  end,
}
