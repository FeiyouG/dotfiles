local telescope = require('telescope')
local actions = require('telescope.actions')

local command_center = require('command_center')
local noremap = {noremap = true}

-- File Pickers
command_center.add({
  {
    description = "Find files",
    command = "Telescope find_files",
    keybindings = { "n", "<leader>ff", noremap },
  }, {
    description = "Find hidden files",
    command = "Telescope find_files hidden=true",
  }, {
    description = "Search within the project (Live grep)",
    command = "Telescope live_grep",
    keybindings = { "n", "<leader>fg", noremap },
  }
})

-- Vim Pickers
command_center.add({
   {
    description = "Find help documentations",
    command = "Telescope help_tags",
    keybindings = { "n", "<leader>fh", noremap },
  }, {
    description = "Show opened buffers",
    command = "Telescope buffers",
    keybindings = { "n", "<leader>fb", noremap },
  }, {
    description = "Find man pages",
    command = "Telescope man_pages",
    keybindings = { "n", "<leader>fm", noremap },
  }, {
    description = "Show all key maps",
    command = "Telescope keymaps",
    keybindings = { "n", "<leader>fk", noremap },
  }, {
    description = "Search inside current buffer",
    command = "Telescope current_buffer_fuzzy_find",
    keybindings = { "n", "<leader>fl", noremap },
  }, {
    description = "Show registers",
    command = "Telescope registers",
    keybindings = { "n", "<leader>fr", noremap },
  }, {
    description = "Show recent files",
    command = "Telescope oldfiles",
  }, {
    description = "Show all available commands",
    command = "Telescope commands",
  }, {
    description = "Show command history",
    command = "Telescope commands",
  }, {
    description = "Show search history (vimgrep)",
    command = "Telescope commands",
  }, {
    description = "Switch colorschemes",
    command = "Telescope colorscheme",
  }, {
    description = "Show jumplist",
    command = "Telescope jumplist",
  }, {
    description = "Edit vim options",
    command = "Telescope vim_options",
  }, {
    description = "List all autocommands",
    command = "Telescope autocommands",
  }, {
    description = "Find telescope builtin commands",
    command = "Telescope builtin",
  }
})

-- Git Pickers
command_center.add({
   {
    description = "Show workspace git commits",
    command = "Telescope git_commits",
  }, {
    description = "Show git commits of current file",
    command = "Telescope git_bcommits",
  }, {
    description = "Show git status",
    command = "Telescope git_status",
  }, {
    description = "Show git branches",
    command = "Telescope ",
  }, {
    description = "Show git stash",
    command = "Telescope git_stash",
  }
})

-- Other Builtin
command_center.add({
  {
    description = "Show treesitter symbols",
    command = "Telescope treesitter",
    keybindings = { "n", "<leader>sts", noremap}
  }
})

-- -- Vim Picker Mappings
-- vim.cmd "nnoremap <leader>fh <cmd>Telescope help_tags<cr>"
-- vim.cmd "nnoremap <leader>fb <cmd>Telescope buffers<cr>"
-- vim.cmd "nnoremap <leader>fm <cmd>Telescope man_pages<cr>"
-- vim.cmd "nnoremap <leader>fk <cmd>Telescope keymaps<cr>"
-- -- vim.cmd "nnoremap <leader>fc <cmd>Telescope commands<cr>"
-- vim.cmd "nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>"
--
--
-- -- Lists Picker
-- vim.cmd "nnoremap <leader>fp <cmd>Telescope builtin<cr>"
--
-- -- LSP Picker Mappings
--
-- -- Treesitter Picker
-- vim.cmd "nnoremap <leader>sts <cmd>Telescope treesitter<cr>"






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
