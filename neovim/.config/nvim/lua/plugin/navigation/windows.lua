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
        -- filetype = {
        --   help = 2,
        -- },
      },
      ignore = {
        buftype = { "quickfix" },
        filetype = {
          "NvimTree",
          "neo-tree",
          "undotree",
          "gundo",
          "notify",
          "DiffviewFiles",
          "Trouble"
        }
      },
      animation = {
        enable = true,
        duration = 100,
        fps = 30,
        easing = "in_out_sine"
      }
    })

    vim.cmd "WindowsDisableAutowidth"
  end,

  commands = function()
    return {
      {
        desc = "Maximize/restore current buffer",
        cmd = "<CMD>WindowsMaximize<CR>",
        keys = { "n", "<C-w>z" },
      }, {
        desc = "Toggle Sliding buffer width",
        cmd = "<CMD>WindowsToggleAutowidth<CR>",
        keys = { "n", "<C-w>w" },
      },
    }
  end
}
