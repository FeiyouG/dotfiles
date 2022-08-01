return function()
  local command_center = Utils.require("command_center")

  local win_mode_name = "window"
  local win_mode_icon = Utils.icons.file.default
  local win_mode_key = "<leader>m"

  local win_mode_cmd = {
    {
      desc = "show all commands in " .. win_mode_name .. " mode",
      cmd = "<CMD>Telescope command_center category=" .. win_mode_name .. "<CR>",
      keys = { "n", "?", Utils.keymap.noremap },
      mode = Utils.keymap.cc_mode.SET
    }, {
      desc = "Exit " .. win_mode_name .. " mode",
      cmd = win_mode_key,
      keys = {
        { "n", win_mode_key , Utils.keymap.nowait },
        { "n", "q" , Utils.keymap.nowait },
      },
      hydra_head_args = { exit = true }
    }, {
      desc = "Go to the window on left",
      cmd = "<C-w>h",
      keys = { "n", "h" }
    }, {
      desc = "Go to the window on right",
      cmd = "<C-w>l",
      keys = { "n", "l" }
    }, {
      desc = "Go to the window on top",
      cmd = "<C-w>k",
      keys = { "n", "k" }
    }, {
      desc = "Go to the window on bottom",
      cmd = "<C-w>j",
      keys = { "n", "j" }
    }, {
      desc = "Close window",
      cmd = "<C-w>c",
      keys = { "n", "c" }
    }
  }

  -- Maximizer
  vim.list_extend(win_mode_cmd, {
    {
      desc = "Zoom in/out current buffer",
      cmd = "<CMD>MaximizerToggle!<CR>",
      keys = { "n", "z" }
    }
  })

  if Utils.require("winshift") then
    vim.list_extend(win_mode_cmd, {
      {
      --   desc = "Swap window",
      --   cmd = "<CMD>WinShift swap<CR>",
      --   keys = { "n", "s" }
      -- }Move, {
        desc = "Move window to left",
        cmd = "<CMD>WinShift left<CR>",
        keys = { "n", "H" }
      }, {
        desc = "Move window to right",
        cmd = "<CMD>WinShift right<CR>",
        keys = { "n", "L" }
      }, {
        desc = "Move window up",
        cmd = "<CMD>WinShift up<CR>",
        keys = { "n", "K" }
      }, {
        desc = "Move window down",
        cmd = "<CMD>WinShift down<CR>",
        keys = { "n", "J" }
      }
    })
  end

  -- MARK: Create hydra
  return {
    name = win_mode_name,
    config = {
      buffer = bufnr,
      color = "pink",
      invoke_on_body = true,
      hint = false,
      on_enter = function()
        vim.o.showtabline = 2
        if command_center then
          command_center.add(win_mode_cmd, {
            mode = command_center.mode.ADD,
            category = win_mode_name,
          })
        end
        Utils.notify.enter_submode(win_mode_name, win_mode_icon)
      end,
      on_exit = function()
        if command_center then
          command_center.remove(win_mode_cmd, {
            mode = command_center.mode.ADD,
            category = win_mode_name,
          })
        end
        Utils.notify.exit_submode(win_mode_name, win_mode_icon)
      end,
    },
    mode = { "n", "x" },
    body = win_mode_key,
    heads = command_center and command_center.converter.to_hydra_heads(win_mode_cmd) or {},
  }
end
