return {
  {
    "folke/trouble.nvim",
    event = { "VeryLazy" },
    keys = {
      { "<leader>xx", "<CMD>TroubleToggle<CR>",                       desc = "Toggle trouble" },
      { "<leader>xq", "<CMD>TroubleToggle quickfix<CR>",              desc = "Toggle quickfix with trouble" },
      { "<leader>xl", "<CMD>TroubleToggle loclist<CR>",               desc = "Toggle quickfix with loclist" },
      { "<leader>xw", "<CMD>TroubleToggle workspace_diagnostics<CR>", desc = "Toggle workspace diagnostic with loclist" },
      { "<leader>xd", "<CMD>TroubleToggle document_diagnostics<CR>",  desc = "Toggle document diagnostic with loclist" },
      {
        "]x",
        function() require("trouble").next({ skip_groups = true, jump = true }) end,
        desc = "Go to next item in trouble"
      },
      {
        "[x",
        function() require("trouble").previous({ skip_groups = true, jump = true }) end,
        desc = "Go to previous item in trouble"
      },
    },
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
          local trouble_provider = require("trouble.providers.telescope")
          return vim.tbl_deep_extend("force", opts, {
            defaults = {
              mappings = {
                n = { ["<C-q>"] = trouble_provider.open_with_trouble },
                i = { ["<C-q>"] = trouble_provider.open_with_trouble }
              }
            }
          })
        end,
      }
    },
    opts = {
      mode = "quickfix",
      fold_open = settings.icons.fs.folder.indicator.open,
      fold_closed = settings.icons.fs.folder.indicator.closed,
      padding = false,
      action_keys = {
        refresh = "<c-r>",
        open_split = "<c-s>",
        jump_close = "gf",
        switch_severity = "<c-f>",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        open_code_href = "c",
        help = "?"
      },
      win_config = { border = settings.icons.editor.border.rounded },
      auto_jump = {},
      signs = {
        error = settings.icons.diagnostic.error,
        warning = settings.icons.diagnostic.warning,
        hint = settings.icons.diagnostic.hint,
        information = settings.icons.diagnostic.info,
        other = settings.icons.diagnostic.other
      },
    }
  },
  {
    "anuvyklack/windows.nvim",

    event = { "VeryLazy" },

    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },

    keys = {
      {
        "<c-w>z",
        "<CMD>WindowsMaximize<CR>",
        desc = "Maximize current buffer with animation",
        mode = "n",
      },
      {
        "<C-w>|",
        "<CMD>WindowsMaximizeHorizontally<CR>",
        desc = "Maximize current buffer horizontally with animation",
        mode = "n"
      },
      {
        "<C-w>_",
        "<CMD>WindowsMaximizeVertically<CR>",
        desc = "Maximize current buffer Vertically with animation",
        mode = "n",
      },
      {
        "<C-w>=",
        "<CMD>WindowsEqualize<CR>",
        desc = "Equalize all buffers with animation",
        mode = "n",
      },
      {
        "<C-w>!",
        "<CMD>WindowsToggleAutowidth<CR>",
        desc = "Toggle Sliding buffer width",
        mode = "n",
      },
    },

    config = function()
      require("windows").setup({
        autowidth = {
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
            "Trouble",
          },
        },
        animation = {
          enable = true,
          duration = 50,
          fps = 30,
          easing = "in_out_sine",
        },
      })

      vim.cmd("WindowsDisableAutowidth")
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",

    keys = {
      "<M-h>",
      "<M-j>",
      "<M-k>",
      "<M-l>",
      "<C-h>",
      "<C-j>",
      "<C-k>",
      "<C-l>",
    },

    config = function()
      local smart_split = require("smart-splits")

      smart_split.setup({
        ignored_filetypes = {
          "nofile",
          "quickfix",
          "prompt",
          "TelescopePrompt",
        },
        multiplexer_integration = true,
      })

      vim.keymap.set("n", "<M-k>", require('smart-splits').resize_up, { desc = "Resize window up" })
      vim.keymap.set("n", "<M-j>", require('smart-splits').resize_down, { desc = "Resize window down" })
      vim.keymap.set("n", "<M-h>", require('smart-splits').resize_left, { desc = "Resize window left" })
      vim.keymap.set("n", "<M-l>", require('smart-splits').resize_right, { desc = "Resize window right" })
      vim.keymap.set("n", "<C-k>", require('smart-splits').move_cursor_up, { desc = "Move to window up" })
      vim.keymap.set("n", "<C-j>", require('smart-splits').move_cursor_down, { desc = "Move to window down" })
      vim.keymap.set("n", "<C-h>", require('smart-splits').move_cursor_left, { desc = "Move to window left" })
      vim.keymap.set("n", "<C-l>", require('smart-splits').move_cursor_right, { desc = "Move to window right" })
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>fp", "<CMD>Telescope projects<CR>", desc = "Search recent porjects" },
    },
    config = function()
      require("project_nvim").setup({
        silent_chdir = true,
      })
      require("telescope").load_extension("projects")
    end
  }

}
