return function()
  local hydra = require("hydra")
  local command_center = Utils.fn.require("command_center")

  local git_mode_name = "Git"
  local git_mode_icon = Utils.constants.icons.git.git
  local git_mode_key = "<leader>g"

  local gitsigns = Utils.fn.require('gitsigns')

  -- MARK: Keybindings
  local git_mode_commands = {}

  if gitsigns then
    vim.list_extend(git_mode_commands, {
      {
        description = "show all commands in git mode",
        cmd = "<CMD>Telescope command_center category=" .. git_mode_name .. "<CR>",
        keybindings = { "n", "?", Utils.constants.keymap.noremap },
      }, {
        description = "Exit git mode",
        cmd = git_mode_key,
        keybindings = { "n", git_mode_key, Utils.constants.keymap.nowait },
        hydra_head_args = { exit = true },
      }, {
        description = "Next hunk",
        cmd = function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gitsigns.next_hunk() end)
          return "<Ignore>"
        end,

        keybindings = { "n", "<C-n>", Utils.constants.keymap.noremap_expr },
      }, {
        description = "Previous hunk",
        cmd = function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gitsigns.prev_hunk() end)
          return "<Ignore>"
        end,

        keybindings = { "n", "<C-p>", Utils.constants.keymap.noremap_expr },
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

  if Utils.fn.require("neogit") then
    vim.list_extend(git_mode_commands, {
      {
        description = "Open neogit",
        cmd = "<CMD>Neogit<CR>",
        keybindings = { "n", "c", },
      }
    })
  end

  if Utils.fn.require("diffview") then
    vim.list_extend(git_mode_commands, {
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


  -- MARK: Create hydra
  hydra({
    name = git_mode_name,
    config = {
      buffer = bufnr,
      color = "pink",
      invoke_on_body = true,
      hint = false,
      on_enter = function()
        vim.cmd("silent! %foldopen!")
        vim.bo.modifiable = false
        if gitsigns then
          gitsigns.toggle_signs(true)
          gitsigns.toggle_linehl(true)
          gitsigns.toggle_current_line_blame(true)
        end

        if command_center then
          command_center.add(git_mode_commands, {
            mode = command_center.mode.ADD,
            category = git_mode_name,
          })
        end
        Utils.fn.notify.enter_submode(Utils.fn.str.separate_snake_case(git_mode_name), git_mode_icon)
      end,
      on_exit = function()
        if gitsigns then
          gitsigns.toggle_signs(false)
          gitsigns.toggle_linehl(false)
          gitsigns.toggle_current_line_blame(false)
        end

        if command_center then
          command_center.remove(git_mode_commands, {
            mode = command_center.mode.ADD,
            category = git_mode_name,
          })
        end
        Utils.fn.notify.exit_submode(Utils.fn.str.separate_snake_case(git_mode_name), git_mode_icon)
      end,
    },
    mode = { "n", "x" },
    body = git_mode_key,
    heads = command_center and command_center.converter.to_hydra_heads(git_mode_commands) or {},
  })
end
