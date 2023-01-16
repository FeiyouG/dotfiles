local M = {
  'nvim-telescope/telescope.nvim',

  requires = {
    'folke/trouble.nvim',
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local trouble = require("trouble.providers.telescope")

    telescope.setup {
      defaults = {
        layout_strategy = 'flex',

        mappings = {
          n = {
            ["q"] = actions.close,
            ["<Esc>"] = actions.close,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-t>"] = actions.select_tab_drop,
            ["<C-f>"] = actions.preview_scrolling_up,
            ["<C-b>"] = actions.preview_scrolling_down,
            ["<C-q>"] = trouble.open_with_trouble,
          },

          i = {
            ["<Esc>"] = actions.close,
            ["<C-u>"] = false, -- Clear the prompt
            ["<C-s>"] = actions.select_horizontal,
            ["<C-t>"] = actions.select_tab_drop,
            ["<C-f>"] = actions.preview_scrolling_up,
            ["<C-b>"] = actions.preview_scrolling_down,
            ["<C-q>"] = trouble.open_with_trouble,
          }
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
  end,

  commands = function()
    local keymap = Utils.keymap

    return {
      -- File Pickers
      {
        desc = "Find files",
        cmd = "<CMD>Telescope find_files<CR>",
        keys = { "n", "<leader>ff", keymap.noremap },
      }, {
        desc = "Find hidden files",
        cmd = "<CMD>Telescope find_files hidden=true<CR>",
      }, {
        desc = "Find string in workspace (Live grep)",
        cmd = "<CMD>Telescope live_grep<CR>",
        keys = { "n", "<leader>fg", keymap.noremap },
      },

      -- File Pickers
      {
        desc = "Find help documentations",
        cmd = "<CMD>Telescope help_tags<CR>",
        keys = { "n", "<leader>fh", keymap.noremap },
      }, {
        desc = "Show opened buffers",
        cmd = "<CMD>Telescope buffers<CR>",
        keys = { "n", "<leader>fb", keymap.noremap },
      }, {
        desc = "Find man pages",
        cmd = "<CMD>Telescope man_pages<CR>",
        keys = { "n", "<leader>fm", keymap.noremap },
      }, {
        desc = "Find key maps",
        cmd = "<CMD>Telescope keymaps<CR>",
        keys = { "n", "<leader>fk", keymap.noremap },
      }, {
        desc = "Find string in current buffer",
        cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        keys = { "n", "<leader>fl", keymap.noremap },
      }, {
        desc = "Show registers",
        cmd = "<CMD>Telescope registers<CR>",
        keys = { "n", "<leader>fr", keymap.noremap },
      }, {
        desc = "Show recent files",
        cmd = "<CMD>Telescope oldfiles<CR>",
      }, {
        desc = "Show all commands",
        cmd = "<CMD>Telescope commands<CR>",
      }, {
        desc = "Show command history",
        cmd = "<CMD>Telescope command_history<CR>",
      }, {
        desc = "Show search history (vimgrep)",
        cmd = "<CMD>Telescope search_history<CR>",
      }, {
        desc = "Show marks",
        cmd = "<CMD>Telescope marks<CR>",
      }, {
        desc = "Switch colorschemes",
        cmd = "<CMD>Telescope colorscheme<CR>",
      }, {
        desc = "Show jumplist",
        cmd = "<CMD>Telescope jumplist<CR>",
      }, {
        desc = "Edit vim options",
        cmd = "<CMD>Telescope vim_options<CR>",
      }, {
        desc = "Show autocommands",
        cmd = "<CMD>Telescope autocommands<CR>",
      }, {
        desc = "Show telescope builtin commands",
        cmd = "<CMD>Telescope builtin<CR>",
      },

      -- Git Pickers
      {
        desc = "Show workspace git commits",
        cmd = "<CMD>Telescope git_commits<CR>",
      }, {
        desc = "Show git branches",
        cmd = "<CMD>Telescope <CR>",
      }, {
        desc = "Show git stash",
        cmd = "<CMD>Telescope git_stash<CR>",
      }
    }
  end
}

return M
