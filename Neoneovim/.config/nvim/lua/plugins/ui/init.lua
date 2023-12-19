return {
  require("plugins.ui.statusline"),
  require("plugins.ui.statuscolum"),
  require("plugins.ui.winbar"),
  {
    "rebelot/heirline.nvim",
    priority = settings.priority.MEDIUM,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "rmehri01/onenord.nvim",
      "lewis6991/gitsigns.nvim",
    },
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("dressing").setup({
        input = {
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["q"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
          win_options = {
            winblend = 5,
          },
        },
        select = {
          backend = { "telescope", "builtin" },
          telescope = require("telescope.themes").get_cursor(),
          win_options = {
            winblend = 5,
          },
          mappings = {
            ["<Esc>"] = "Close",
            ["q"] = "Close",
            ["<C-c>"] = "Close",
            ["<CR>"] = "Confirm",
          },
        },
      })

      vim.list_extend(settings.ft.exclude_winbar.filetype, { "dressinginput", "dressingselect" })
      vim.list_extend(settings.ft.quit_on_q.filetype, { "dressinginput", "dressingselect" })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = { "VeryLazy" },
    config = function()
      require("neoscroll").setup()
      require("neoscroll.config").set_mappings({
        ["<C-y>"] = { "scroll", { "-1", "true", "100" } },
        ["<C-e>"] = { "scroll", { "1", "true", "100" } },
      })
    end,
  },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    "rcarriga/nvim-notify",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    commander = {
      {
        desc = "View notification history",
        cmd = "<CMD>Telescope notify<CR>"
      }
    },
    config = function()
      vim.notify = require("notify")
    end
  }
}
