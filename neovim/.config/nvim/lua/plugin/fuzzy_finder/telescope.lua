local M = {
  'nvim-telescope/telescope.nvim',

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

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
          },

          i = {
            ["<Esc>"] = actions.close,
            ["<C-u>"] = false, -- Clear the prompt
            ["<C-s>"] = actions.select_horizontal,
            ["<C-f>"] = actions.preview_scrolling_up,
            ["<C-b>"] = actions.preview_scrolling_down,
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

  defer = function()
    -- MARK: Register and add to command_center
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    local noremap = { noremap = true }

    -- File Pickers
    command_center.add({
      {
        description = "Find files",
        cmd = "<cmd>Telescope find_files<CR>",
        keybindings = { "n", "<leader>ff", noremap },
      }, {
        description = "Find hidden files",
        cmd = "<cmd>Telescope find_files hidden=true<CR>",
      }, {
        description = "Find string in workspace (Live grep)",
        cmd = "<cmd>Telescope live_grep<CR>",
        keybindings = { "n", "<leader>fg", noremap },
      }
    })

    -- Vim Pickers
    command_center.add({
      {
        description = "Find help documentations",
        cmd = "<cmd>Telescope help_tags<CR>",
        keybindings = { "n", "<leader>fh", noremap },
      }, {
        description = "Show opened buffers",
        cmd = "<cmd>Telescope buffers<CR>",
        keybindings = { "n", "<leader>fb", noremap },
      }, {
        description = "Find man pages",
        cmd = "<cmd>Telescope man_pages<CR>",
        keybindings = { "n", "<leader>fm", noremap },
      }, {
        description = "Find key maps",
        cmd = "<cmd>Telescope keymaps<CR>",
        keybindings = { "n", "<leader>fk", noremap },
      }, {
        description = "Find string in current buffer",
        cmd = "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        keybindings = { "n", "<leader>fl", noremap },
      }, {
        description = "Show registers",
        cmd = "<cmd>Telescope registers<CR>",
        keybindings = { "n", "<leader>fr", noremap },
      }, {
        description = "Show recent files",
        cmd = "<cmd>Telescope oldfiles<CR>",
      }, {
        description = "Show all commands",
        cmd = "<cmd>Telescope commands<CR>",
      }, {
        description = "Show command history",
        cmd = "<cmd>Telescope command_history<CR>",
      }, {
        description = "Show search history (vimgrep)",
        cmd = "<cmd>Telescope search_history<CR>",
      }, {
        description = "Switch colorschemes",
        cmd = "<cmd>Telescope colorscheme<CR>",
      }, {
        description = "Show jumplist",
        cmd = "<cmd>Telescope jumplist<CR>",
      }, {
        description = "Edit vim options",
        cmd = "<cmd>Telescope vim_options<CR>",
      }, {
        description = "Show autocommands",
        cmd = "<cmd>Telescope autocommands<CR>",
      }, {
        description = "Show telescope builtin commands",
        cmd = "<cmd>Telescope builtin<CR>",
      }
    })

    -- Git Pickers
    command_center.add({
      {
        description = "Show workspace git commits",
        cmd = "<cmd>Telescope git_commits<CR>",
      }, {
        description = "Show git commits of current buffer",
        cmd = "<cmd>Telescope git_bcommits<CR>",
      -- }, {
      --   description = "Show git status",
      --   cmd = "<cmd>Telescope git_status<CR>",
      }, {
        description = "Show git branches",
        cmd = "<cmd>Telescope <CR>",
      }, {
        description = "Show git stash",
        cmd = "<cmd>Telescope git_stash<CR>",
      }
    })

    -- Other Builtin
    command_center.add({
      {
        description = "Show treesitter symbols",
        cmd = "<cmd>Telescope treesitter<CR>",
        keybindings = { "n", "<leader>sts", noremap }
      }
    })
  end
}

return M
