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

    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      -- Setup telescope config
      local telescope_config = {
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
      }

      if (settings.fn.plugin.is_installed("trouble")) then
        local trouble = require("trouble.providers.telescope")
        telescope_config.defaults.mappings.n["<C-q>"] = trouble.open_with_trouble
        telescope_config.defaults.mappings.i["<C-q>"] = trouble.open_with_trouble
      end

      telescope.setup(telescope_config)

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
  

  -- {
  --   "git@github.com:FeiyouG/command_center.nvim.git",
  --   dev = true,
  --   priority = settings.priority.HIGH,
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     local commander = require("commander")
  --     commander.setup({
  --       components = {
  --         commander.component.DESC,
  --         commander.component.KEYS,
  --         commander.component.CAT,
  --       },
  --       sort_by = {
  --         commander.component.DESC,
  --         commander.component.CAT,
  --         commander.component.KEYS,
  --         commander.component.CMD,
  --       },
  --       auto_replace_desc_with_cmd = true,
  --       telescope = {
  --         integrate = true,
  --         theme = require("telescope.themes").commander,
  --       },
  --     })
  --
  --     settings.fn.keymap.set({
  --       {
  --         desc = "Open Commander",
  --         cmd = "<CMD>Telescope commander<CR>",
  --         keys = {
  --           -- If ever hesitate when using telescope start with <leader>f,
  --           -- also open command center
  --           { { "n", "x" }, "<Leader>f" },
  --           { { "n", "x" }, "<Leader>fc" },
  --         },
  --       },
  --     })
  --   end,
  -- },
}
