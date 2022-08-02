return {
  name = "windows",
  icon = Utils.icons.layout,
  key = "<leader>m",
  color = "pink",
  mode = { "n", "x" },

  on_enter = function()
    vim.o.showtabline = 2
  end,

  on_exit = function()
    vim.o.showtabline = 0
  end,

  commands = function()
    local commands = {
      {
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
    vim.list_extend(commands, {
      {
        desc = "Zoom in/out current buffer",
        cmd = "<CMD>MaximizerToggle!<CR>",
        keys = { "n", "z" }
      }
    })

    if Utils.require("winshift") then
      vim.list_extend(commands, {
        {
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

    return commands
  end
}
