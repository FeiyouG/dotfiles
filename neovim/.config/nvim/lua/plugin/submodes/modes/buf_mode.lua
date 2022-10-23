return {
  name = "buffer",
  icon = Utils.icons.file.default,
  key = "b",
  color = "pink",
  mode = { "n", "x" },

  on_enter = function()
    if Utils.require("lualine") then
      Utils.state.statusline.show_tabs = true
    end
  end,

  on_exit = function()
    if Utils.require("lualine") then
      Utils.state.statusline.show_tabs = false
    end
  end,

  commands = function()
    local commands = {
      {
        desc = "Delete current buffer and maintain layout",
        cmd = "<CMD>bdelete<CR>",
        keys = { "n", "<c-d>" }
      }, {
        desc = "Remove current window",
        cmd = "<CMD>close<CR>",
        keys = { "n", "<c-c>" }
      }, {
        desc = "Go to 1st tabpage",
        cmd = "1gt",
        keys = { "n", "1" }
      }, {
        desc = "Go to 2nd tabpage",
        cmd = "2gt",
        keys = { "n", "2" }
      }, {
        desc = "Go to 3rd tabpage",
        cmd = "3gt",
        keys = { "n", "3" }
      }, {
        desc = "Go to 4th tabpage",
        cmd = "4gt",
        keys = { "n", "4" }
      }, {
        desc = "Go to 5th tabpage",
        cmd = "5gt",
        keys = { "n", "5" }
      }, {
        desc = "Go to 6th tabpage",
        cmd = "6gt",
        keys = { "n", "6" }
      }, {
        desc = "Go to 7th tabpage",
        cmd = "7gt",
        keys = { "n", "7" }
      }, {
        desc = "Go to 8th tabpage",
        cmd = "8gt",
        keys = { "n", "8" }
      }, {
        desc = "Go to 9th tabpage",
        cmd = "9gt",
        keys = { "n", "9" }
      }, {
        desc = "Go to previous tabpage",
        cmd = "<CMD>tabprevious<CR>",
        keys = { "n", "<Left>" }
      }, {
        desc = "Go to next tabpage",
        cmd = "<CMD>tabnext<CR>",
        keys = { "n", "<Right>" }
      },
    }

    if Utils.require("windows") then
      vim.list_extend(commands, {
        {
          desc = "Maximize current buffer with animation",
          cmd = "<CMD>WindowsMaximize<CR>",
          keys = { "n", "<c-z>" },
        }, {
          desc = "Maximize current buffer horizontally with animation",
          cmd = "<CMD>WindowsMaximizeHorizontally<CR>",
          keys = { "n", "|" },
        }, {
          desc = "Maximize current buffer Vertically with animation",
          cmd = "<CMD>WindowsMaximizeVertically<CR>",
          keys = { "n", "_" },
        }, {
          desc = "Equalize all buffers with animation",
          cmd = "<CMD>WindowsEqualize<CR>",
          keys = { "n", "=" },
        }, {
          desc = "Toggle Sliding buffer width",
          cmd = "<CMD>WindowsToggleAutowidth<CR>",
          keys = { "n", "<c-w>" },
        },
      })
    end

    if Utils.require("cybu") then
      vim.list_extend(commands, {
        {
          desc = "Select previous buffer",
          cmd = "<Plug>(CybuPrev)",
          keys = {
            { "n", "<Up>", Utils.keymap.remap }
          },
        }, {
          desc = "Select previous buffer",
          cmd = "<Plug>(CybuNext)",
          keys = {
            { "n", "<Down>", Utils.keymap.remap }
          },
        },
      })
    end

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
