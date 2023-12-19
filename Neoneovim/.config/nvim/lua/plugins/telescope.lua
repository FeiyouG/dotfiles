return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "folke/trouble.nvim",
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
          require("telescope").load_extension("dap")
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      { "<leader>ff", "<CMD>Telescope find_files<CR>", mode = "n", desc = "Find files" },
      { "<leader>fk", "<CMD>Telescope keymaps<CR>",    mode = "n", desc = "Find keymaps" },
      { "<leader>fb", "<CMD>Telescope buffers<CR>",    mode = "n", desc = "Find buffers" },
      { "<leader>fg", "<CMD>Telescope live_grep<CR>",  mode = "n", desc = "Find string in workspace" },
      { "<leader>fh", "<CMD>Telescope help_tags<CR>",  mode = "n", desc = "Search help" },
      {
        "<leader>fl",
        "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        mode = "n",
        desc = "Find line in current buffer"
      },
    },

    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      -- Setup telescope config
      opts = vim.tbl_deep_extend("force", opts, {
        defaults = {
          layout_strategy = "flex",
          mappings = {
            n = {
              ["q"] = actions.close,
              ["<Esc>"] = actions.close,
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<C-t>"] = actions.select_tab,
              ["<C-f>"] = actions.preview_scrolling_up,
              ["<C-b>"] = actions.preview_scrolling_down,
            },
            i = {
              ["<Esc>"] = actions.close,
              ["<C-u>"] = false, -- Clear the prompt
              ["<C-s>"] = actions.select_horizontal,
              ["<C-t>"] = actions.select_tab,
              ["<C-f>"] = actions.preview_scrolling_up,
              ["<C-b>"] = actions.preview_scrolling_down,
            },
          },
          file_ignore_patterns = {
            "node_modules",
          },
        },
        pickers = {
          lsp_code_actions = {
            theme = "cursor",
          },
        },
      })

      telescope.setup(opts)

      -- Filetype update
      vim.list_extend(settings.ft.exclude_winbar.filetype, {
        "TelescopePrompt",
        "TelescopeResults",
      })
    end,
  },
  {
    "axieax/urlview.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>fu",  "<Cmd>UrlView<CR>",      mode = { "n", "v" }, desc = "Show all buffer links" },
      { "<leader>fub", "<Cmd>UrlView<CR>",      mode = { "n", "v" }, desc = "Show all buffer links" },
      { "<leader>fup", "<Cmd>UrlView lazy<CR>", mode = { "n", "v" }, desc = "Show all plugin links" },
      { "[u" },
      { "]" }
    },
    config = function()
      require("urlview").setup({
        default_picker = "telescope",
        default_prefix = "https://",
        default_action = "system",
        unique = true,
        sorted = true,
        jump = {
          ["prev"] = "[u",
          ["next"] = "]u",
        },
      })
    end,
  },
  {
    "FeiyouG/commander.nvim",
    -- dir = "~/.local/share/nvim/dev/commander.nvim",
    -- dev = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    commander = {
      {
        desc = "Open Commander",
        cmd = function() require("commander").show() end,
        keys = {
          { "n", "<leader>f" },
          { "n", "<leader>fc" },
        },
      }
    },
    opts = {
      components = {
        "DESC",
        "KEYS",
        "CAT",
      },
      sort_by = {
        "DESC",
        "KEYS",
        "CAT",
        "CMD"
      },

      integration = {
        telescope = {
          enable = true,
        },
        lazy = {
          enable = true,
          set_plugin_name_as_cat = true
        }
      }
    }
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
          return vim.tbl_deep_extend("force", opts, {
            extensions = {
              file_browser = {
                theme = "dropdown",
                hijack_netrw = false,
              }
            }
          })
        end,
      },
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ft", "<CMD>Telescope file_browser<CR>", desc = "Browse files with telescope" },
    },
    config = function()
      require("telescope").load_extension("file_browser")
    end
  }
}
