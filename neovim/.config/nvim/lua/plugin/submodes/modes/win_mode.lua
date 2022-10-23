return {
  name = "window",
  icon = Utils.icons.layout,
  key = "w",
  color = "pink",
  mode = { "n", "x" },

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
        keys = {
          { "n", "c" },
          { "n", "<c-c>" }
        }
      }, {
        desc = "split window",
        cmd = "<C-w>s",
        keys = { "n", "s" }
      }, {
        desc = "Vertically split window",
        cmd = "<C-w>v",
        keys = { "n", "v" }
      }
    }

    -- Maximizer
    vim.list_extend(commands, {
      {
        desc = "Maximize current buffer with animation",
        cmd = "<CMD>WindowsMaximize<CR>",
        keys = {
          { "n", "z" },
          { "n", "<c-z>" },
        }
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
        keys = { "n", "!" },
      },
    })


    return commands
  end
}
