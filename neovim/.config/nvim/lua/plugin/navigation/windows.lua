return {
  "anuvyklack/windows.nvim",

  requires = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim"
  },

  config = function()

    require("windows").setup({
      autowidth = {
        enable = true,
        winwidth = 8,
        filetype = {
          NvimTree = 2,
        },
      },
      ignore = {
        buftype = { "quickfix" },
        filetype = {
          "undotree",
          "gundo",
          "notify",
          "DiffviewFiles",
          "Trouble"
        }
      },
      animation = {
        enable = true,
        duration = 50,
        fps = 30,
        easing = "in_out_sine"
      }
    })

    vim.cmd "WindowsDisableAutowidth"
  end,

  commands = function()
    return {
      {
        desc = "Maximize current buffer with animation",
        cmd = "<CMD>WindowsMaximize<CR>",
        keys = {
          { "n", "<c-w>z" },
          { "n", "<c-w><c-z>" },
        }
      }, {
        desc = "Maximize current buffer horizontally with animation",
        cmd = "<CMD>WindowsMaximizeHorizontally<CR>",
        keys = { "n", "<C-w>|" },
      }, {
        desc = "Maximize current buffer Vertically with animation",
        cmd = "<CMD>WindowsMaximizeVertically<CR>",
        keys = { "n", "<C-w>_" },
      }, {
        desc = "Equalize all buffers with animation",
        cmd = "<CMD>WindowsEqualize<CR>",
        keys = { "n", "<C-w>=" },
      }, {
        desc = "Toggle Sliding buffer width",
        cmd = "<CMD>WindowsToggleAutowidth<CR>",
        keys = { "n", "<C-w>!" },
      },
    }
  end
}
