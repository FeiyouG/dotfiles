return {
  name = "git",
  icon = Utils.icons.git.git,
  key = "<leader>g",
  color = "pink",
  mode = { "n", "x" },

  on_enter = function()
    local gitsigns = Utils.require("gitsigns")

    vim.cmd("silent! %foldopen!")
    vim.bo.modifiable = false
    if gitsigns then
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
      gitsigns.toggle_current_line_blame(true)
    end
  end,

  on_exit = function()
    local gitsigns = Utils.require("gitsigns")

    vim.bo.modifiable = true
    if gitsigns then
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_current_line_blame(false)
    end
  end,

  commands = function()
    local gitsigns = Utils.require("gitsigns")
    local commands = {}

    if gitsigns then
      vim.list_extend(commands, {
        {
          description = "Next hunk",
          cmd = function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return "<Ignore>"
          end,

          keybindings = { "n", "<C-n>", Utils.keymap.noremap_expr },
        }, {
          description = "Previous hunk",
          cmd = function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return "<Ignore>"
          end,

          keybindings = { "n", "<C-p>", Utils.keymap.noremap_expr },
        }, {
          description = "Stage hunk",
          cmd = gitsigns.stage_hunk,
          keybindings = { "n", "s", },
        }, {
          description = "Undo stage hunk",
          cmd = gitsigns.undo_stage_hunk,
          keybindings = { "n", "u", },
        }, {
          description = "reset hunk",
          cmd = function()
            vim.bo.modifiable = true
            gitsigns.reset_hunk()
            vim.bo.modifiable = false
          end,
        }, {
          description = "Stage buffer",
          cmd = gitsigns.stage_buffer,
          keybindings = { "n", "S" },
        }, {
          description = "Preview hunk",
          cmd = gitsigns.preview_hunk,
          keybindings = { "n", "K" },
        }, {
          description = "View line blame",
          cmd = gitsigns.blame_line,
          keybindings = { "n", "b" },
        }, {
          description = "Toggle deleted",
          cmd = gitsigns.toggle_deleted,
          keybindings = { "n", "<leader>d" },
        }, {
          description = "View line blame (full)",
          cmd = function() gitsigns.blame_line({ full = true }) end,
          keybindings = { "n", "B", },
        }, {
          desc = "send git hunks to location list",
          cmd = gitsigns.setloclist,
        }, {
          desc = "Send git hunks to quick fix list",
          cmd = gitsigns.setqflist,
        }
      }
      )
    end

    if Utils.require("neogit") then
      vim.list_extend(commands, {
        {
          description = "Open neogit",
          cmd = "<CMD>Neogit<CR>",
          keybindings = { "n", "c", },
        }
      })
    end

    if Utils.require("diffview") then
      vim.list_extend(commands, {
        {
          description = "Open diffview",
          cmd = "<CMD>DiffviewOpen<CR>",
          keybindings = { "n", "dv", },
        }, {
          description = "Open file commit history panel",
          cmd = "<CMD>DiffviewFileHistory<CR>",
          keybindings = { "n", "df", },
        }, {
          description = "Close diffview/file commit history panel",
          cmd = "<CMD>DiffviewClose<CR>",
          keybindings = { "n", "q", },
        },

      })
    end

    return commands
  end
}
