return function()
  local hydra = require("hydra")
  local command_center = require("command_center")
  local gitsigns = require('gitsigns')

  local utils = require("utils")
  local git_mode_name = "Git"
  local git_mode_icon = utils.constants.icons.git.git
  local git_mode_key = "<leader>g"

  local noremap = { noremap = true }

  -- MARK: Keybindings
  local git_mode_commands = {
    {
      description = "show all commands in git mode",
      cmd = "<CMD>Telescope command_center category=" .. git_mode_name .. "<CR>",
      keybindings = { "n", "?", noremap },
    }, {
      description = "Exit git mode",
      cmd = git_mode_key,
      keybindings = { "n", git_mode_key, { nowait = true } },
      hydra_head_args = { exit = true },
      category = git_mode_name,
    }, {
      description = "Next hunk",
      cmd = function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return "<Ignore>"
      end,

      keybindings = { "n", "<C-n>", { noremap = true, expr = true } },
      category = git_mode_name,
    }, {
      description = "Previous hunk",
      cmd = function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return "<Ignore>"
      end,

      keybindings = { "n", "<C-p>", { noremap = true, expr = true } },
      category = git_mode_name,
    }, {
      description = "Stage hunk",
      cmd = gitsigns.stage_hunk,
      keybindings = { "n", "s", {} },
      category = git_mode_name,
    }, {
      description = "Undo stage hunk",
      cmd = gitsigns.undo_stage_hunk,
      keybindings = { "n", "u", {} },
      category = git_mode_name,
    }, {
      description = "Stage buffer",
      cmd = gitsigns.stage_buffer,
      keybindings = { "n", "S", {} },
      category = git_mode_name,
    }, {
      description = "Preview hunk",
      cmd = gitsigns.preview_hunk,
      keybindings = { "n", "K", {} },
      category = git_mode_name,
    }, {
      description = "View line blame",
      cmd = gitsigns.blame_line,
      keybindings = { "n", "b", {} },
      category = git_mode_name
    },{
      description = "Toggle deleted",
      cmd = gitsigns.toggle_deleted,
      keybindings = { "n", "<leader>d", {} },
      category = git_mode_name
    }, {
      description = "View line blame (full)",
      cmd = function() gitsigns.blame_line({ full = true }) end,
      keybindings = { "n", "B", {} },
      category = git_mode_name
    }, {
      description = "Open neogit",
      cmd = "<CMD>Neogit<CR>",
      keybindings = { "n", "c", {} },
      category = git_mode_name
    }, {
      description = "Open diffview",
      cmd = "<CMD>DiffviewOpen<CR>",
      keybindings = { "n", "dv", {} },
      category = git_mode_name
    }, {
      description = "Open file commit history panel",
      cmd = "<CMD>DiffviewFileHistory<CR>",
      keybindings = { "n", "df", {} },
      category = git_mode_name
    }, {
      description = "Close diffview/file commit history panel",
      cmd = "<CMD>DiffviewClose<CR>",
      keybindings = { "n", "q", {} },
      category = git_mode_name
    },
  }


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
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
        gitsigns.toggle_current_line_blame(true)

        command_center.add(git_mode_commands, command_center.mode.ADD_ONLY)
        utils.notify.enter_mode(utils.string.separate_snake_case(git_mode_name), git_mode_icon)
      end,
      on_exit = function()
        gitsigns.toggle_signs(false)
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_current_line_blame(false)

        command_center.remove(git_mode_commands)
        utils.notify.exit_mode(utils.string.separate_snake_case(git_mode_name), git_mode_icon)
      end,
    },
    mode = { "n", "x" },
    body = git_mode_key,
    heads = command_center.converter.to_hydra_heads(git_mode_commands),
  })
end
