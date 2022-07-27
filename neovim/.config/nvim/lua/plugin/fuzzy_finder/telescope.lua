local M = {
  'nvim-telescope/telescope.nvim',

  require = {
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
            ["<C-f>"] = actions.preview_scrolling_up,
            ["<C-b>"] = actions.preview_scrolling_down,
            ["<C-q>"] = trouble.open_with_trouble,
          },

          i = {
            ["<Esc>"] = actions.close,
            ["<C-u>"] = false, -- Clear the prompt
            ["<C-s>"] = actions.select_horizontal,
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
    -- MARK: Register and add to command_center
    local utils = require("utils")

    return {
      -- File Pickers
      {
        description = "Find files",
        cmd = "<CMD>Telescope find_files<CR>",
        keybindings = { "n", "<leader>ff", utils.keymap.noremap },
      }, {
        description = "Find hidden files",
        cmd = "<CMD>Telescope find_files hidden=true<CR>",
      }, {
        description = "Find string in workspace (Live grep)",
        cmd = "<CMD>Telescope live_grep<CR>",
        keybindings = { "n", "<leader>fg", utils.keymap.noremap },
      },

      -- File Pickers
      {
        description = "Find help documentations",
        cmd = "<CMD>Telescope help_tags<CR>",
        keybindings = { "n", "<leader>fh", utils.keymap.noremap },
      }, {
        description = "Show opened buffers",
        cmd = "<CMD>Telescope buffers<CR>",
        keybindings = { "n", "<leader>fb", utils.keymap.noremap },
      }, {
        description = "Find man pages",
        cmd = "<CMD>Telescope man_pages<CR>",
        keybindings = { "n", "<leader>fm", utils.keymap.noremap },
      }, {
        description = "Find key maps",
        cmd = "<CMD>Telescope keymaps<CR>",
        keybindings = { "n", "<leader>fk", utils.keymap.noremap },
      }, {
        description = "Find string in current buffer",
        cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        keybindings = { "n", "<leader>fl", utils.keymap.noremap },
      }, {
        description = "Show registers",
        cmd = "<CMD>Telescope registers<CR>",
        keybindings = { "n", "<leader>fr", utils.keymap.noremap },
      }, {
        description = "Show recent files",
        cmd = "<CMD>Telescope oldfiles<CR>",
      }, {
        description = "Show all commands",
        cmd = "<CMD>Telescope commands<CR>",
      }, {
        description = "Show command history",
        cmd = "<CMD>Telescope command_history<CR>",
      }, {
        description = "Show search history (vimgrep)",
        cmd = "<CMD>Telescope search_history<CR>",
      }, {
        description = "Show marks",
        cmd = "<CMD>Telescope marks<CR>",
      }, {
        description = "Switch colorschemes",
        cmd = "<CMD>Telescope colorscheme<CR>",
      }, {
        description = "Show jumplist",
        cmd = "<CMD>Telescope jumplist<CR>",
      }, {
        description = "Edit vim options",
        cmd = "<CMD>Telescope vim_options<CR>",
      }, {
        description = "Show autocommands",
        cmd = "<CMD>Telescope autocommands<CR>",
      }, {
        description = "Show telescope builtin commands",
        cmd = "<CMD>Telescope builtin<CR>",
      },

      -- Git Pickers
      {
        description = "Show workspace git commits",
        cmd = "<CMD>Telescope git_commits<CR>",
      }, {
        description = "Show git branches",
        cmd = "<CMD>Telescope <CR>",
      }, {
        description = "Show git stash",
        cmd = "<CMD>Telescope git_stash<CR>",
      }
    }
  end
}

return M
