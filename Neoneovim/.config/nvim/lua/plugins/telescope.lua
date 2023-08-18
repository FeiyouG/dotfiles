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

      if (settings.fn.is_installed("trouble.nvim")) then
        local trouble = require("trouble.providers.telescope")
        telescope_config.defaults.mappings.n["<C-q>"] = trouble.open_with_trouble
        telescope_config.defaults.mappings.i["<C-q>"] = trouble.open_with_trouble
      end

      telescope.setup(telescope_config)

      -- Setup keymaps
      vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fk", "<CMD>Telescope keymaps<CR>", { desc = "Find keymaps" })
      vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>", { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", { desc = "Find string in workspace" })
      vim.keymap.set("n", "<leader>fl", "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        { desc = "Find line in current buffer" })
      -- settings.fn.keymap.set({
      --   {
      --     desc = "Find hidden files",
      --     cmd = "<CMD>Telescope find_files hidden=true<CR>",
      --   },
      --   {
      --     desc = "Show recent files",
      --     cmd = "<CMD>Telescope oldfiles<CR>",
      --   },
      --   {
      --     desc = "Show all commands",
      --     cmd = "<CMD>Telescope commands<CR>",
      --   },
      --   {
      --     desc = "Show command history",
      --     cmd = "<CMD>Telescope command_history<CR>",
      --   },
      --   {
      --     desc = "Show search history (vimgrep)",
      --     cmd = "<CMD>Telescope search_history<CR>",
      --   },
      --   {
      --     desc = "Show marks",
      --     cmd = "<CMD>Telescope marks<CR>",
      --   },
      --   {
      --     desc = "Switch colorschemes",
      --     cmd = "<CMD>Telescope colorscheme<CR>",
      --   },
      --   {
      --     desc = "Show jumplist",
      --     cmd = "<CMD>Telescope jumplist<CR>",
      --   },
      --   {
      --     desc = "Edit vim options",
      --     cmd = "<CMD>Telescope vim_options<CR>",
      --   },
      --   {
      --     desc = "Show autocommands",
      --     cmd = "<CMD>Telescope autocommands<CR>",
      --   },
      --   {
      --     desc = "Show telescope builtin commands",
      --     cmd = "<CMD>Telescope builtin<CR>",
      --   },
      --
      --   -- Git Pickers
      --   {
      --     desc = "Show workspace git commits",
      --     cmd = "<CMD>Telescope git_commits<CR>",
      --   },
      --   {
      --     desc = "Show git branches",
      --     cmd = "<CMD>Telescope <CR>",
      --   },
      --   {
      --     desc = "Show git stash",
      --     cmd = "<CMD>Telescope git_stash<CR>",
      --   },
      -- })

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

      vim.keymap.set({ "n", "v" }, "<leader>fu", "<Cmd>UrlView<CR>", { desc = "Show all buffer links" })
      vim.keymap.set({ "n", "v" }, "<leader>fub", "<Cmd>UrlView<CR>", { desc = "Show all buffer links" })
      vim.keymap.set({ "n", "v" }, "<leader>fup", "<Cmd>UrlView lazy<CR>", { desc = "Show all plugin links" })
    end,
  },
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
  }

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
