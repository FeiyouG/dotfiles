return {
  'lewis6991/gitsigns.nvim',

  config = function()
    require('gitsigns').setup {
      signs = {
        add          = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      },

      signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

      watch_gitdir        = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,

      current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority                = 6,
      update_debounce              = 100,
      status_formatter             = nil, -- Use default
      max_file_length              = 40000,
      preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm                         = {
        enable = false
      },

    }
  end,

  defer = function()
    local has_command_center, command_center = pcall(require, "command_center")
    if not has_command_center then return end

    local noremap = { noremap = true }
    local gs = require("gitsigns")

    command_center.add({
      {
        description = "Turn off all gitsigns function",
        cmd = function()
          gs.toggle_signs(false)
          gs.toggle_numhl(false)
          gs.toggle_word_diff(false)
          gs.toggle_linehl(false)
          gs.toggle_current_line_blame(false)
        end
      }, {
        description = "Toggle git signs and line number highlight",
        cmd = gs.toggle_signs,
        keybindings = {
          { "n", "<leader>gs", noremap },
          { "n", "<leader>gss", noremap },
        },
      }, {
        description = "Toggle git line highlight",
        cmd = gs.toggle_linehl,
        keybindings = { "n", "<leader>gsl", noremap },
      }, {
        description = "Toggle git word diff",
        cmd = gs.toggle_word_diff,
      }, {
        description = "Toggle git blame on cursor hold",
        cmd = gs.toggle_current_line_blame,
        keybindings = { "n", "<leader>gb", noremap },
      }, {
        description = "Git blame current line",
        cmd = function() gs.blame_line() end,
        keybindings = { "n", "<leader>gB", noremap },
      }, {
        description = "Git preview hunk",
        cmd = gs.preview_hunk,
        keybindings = { "n", "<leader>gH", noremap },
      }, {
        description = "Git stage hunk",
        cmd = "<CMD>Gitsigns stage_hunk<CR>",
        keybindings = {
          { "n", "<leader>ghs", noremap },
          { "v", "<leader>ghs", noremap },
        }
      }, {
        description = "Git undo hunk",
        cmd = gs.undo_stage_hunk,
        keybindings = { "n", "<leader>ghu", noremap },
      }, {
        description = "Git reset hunk",
        cmd = "<CMD>Gitsigns reset_hunk<CR>",
        keybindings = {
          { "n", "<leader>ghr", noremap },
          { "v", "<leader>ghr", noremap },
        }
      }, {
        cmd = function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end,
        keybindings = { "n", "]c", noremap },
        mode = command_center.mode.REGISTER_ONLY,
      }, {
        cmd = function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end,
        keybindings = { "n", "[c", noremap },
        mode = command_center.mode.REGISTER_ONLY,
      }
    })

  end
}
