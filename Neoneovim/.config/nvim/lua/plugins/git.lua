return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame_opts = {
        delay = 200,
        ignore_whitespace = true,
      },
      preview_config = {
        border = settings.icons.editor.border.rounded,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local diffview = require("diffview")
      local actions = require("diffview.actions")

      diffview.setup({
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
          },
        },
        icons = {
          folder_closed = settings.icons.fs.folder.closed,
          folder_open = settings.icons.fs.folder.open,
        },
        signs = {
          fold_closed = settings.icons.fs.folder.indicator.closed,
          folder_open = settings.icons.fs.folder.indicator.open,
        },
        key_bindings = {
          view = {
            ["q"] = actions.close,
          }
        }
      })

      vim.keymap.set({ "n" }, "<leader>gd", "<CMD>DiffviewOpen<CR>", { desc = "Open Diffview" })
      vim.keymap.set({ "n" }, "<leader>gf", "<CMD>DiffviewFileHistory<CR>", { desc = "Open File History" })
    end,
  },
  {
    "TimUntersberger/neogit",

    event = { "VeryLazy" },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },

    config = function()
      local neogit = require("neogit")

      neogit.setup({
        disable_context_highlighting = true,
        auto_refresh = false,
        signs = {
          -- { CLOSED, OPENED }
          section = { settings.icons.fs.folder.indicator.closed, settings.icons.fs.folder.indicator.open },
          item = { settings.icons.fs.folder.indicator.closed, settings.icons.fs.folder.indicator.open },
          hunk = { settings.icons.fs.folder.indicator.closed, settings.icons.fs.folder.indicator.open },
        },
        integrations = {
          diffview = true,
        },
        -- Setting any section to `false` will make the section not render at all
        sections = {
          untracked = {
            folded = false,
          },
          unstaged = {
            folded = false,
          },
          staged = {
            folded = false,
          },
          stashes = {
            folded = true,
          },
          unpulled = {
            folded = true,
          },
          unmerged = {
            folded = false,
          },
          recent = {
            folded = true,
          },
        },
        -- override/add mappings
        mappings = {
          -- modify status buffer mappings
          status = {
            ["s"] = "Stage",
            ["u"] = "Unstage",
            ["<Return>"] = "Toggle",
            ["q"] = "Close",
            ["<leader>r"] = "RefreshBuffer",
          },
        },
      })

      vim.keymap.set({ "n" }, "<leader>gc", neogit.open, { desc = "Open Neogit" })
    end,
  }
}
