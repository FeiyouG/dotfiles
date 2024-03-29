local style = require("settings.style")
local fn = require("settings.fn")

return {
  name = "git",
  icon = style.icons.git.git,
  key = "g",
  color = "pink",
  mode = { "n", "x" },

  on_enter = function()
    local gitsigns = fn.require("gitsigns")

    if gitsigns then
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
      gitsigns.toggle_current_line_blame(true)
    end
  end,

  on_exit = function()
    local gitsigns = fn.require("gitsigns")

    if gitsigns then
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_current_line_blame(false)
    end
  end,

  commands = function()
    local gitsigns = fn.require("gitsigns")
    local commands = {}

    if gitsigns then
      vim.list_extend(commands, {
        {
          desc = "Next hunk",
          cmd = function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gitsigns.next_hunk()
            end)
            return "<Ignore>"
          end,

          keys = { "n", "<C-n>" },
        },
        {
          desc = "Previous hunk",
          cmd = function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gitsigns.prev_hunk()
            end)
            return "<Ignore>"
          end,

          keys = { "n", "<C-p>" },
        },
        {
          desc = "Stage hunk",
          cmd = gitsigns.stage_hunk,
          keys = { "n", "<c-s>" },
        },
        {
          desc = "Undo stage hunk",
          cmd = gitsigns.undo_stage_hunk,
          keys = { "n", "<c-u>" },
        },
        {
          desc = "reset hunk",
          cmd = function()
            vim.bo.modifiable = true
            gitsigns.reset_hunk()
            vim.bo.modifiable = false
          end,
        },
        {
          desc = "Stage buffer",
          cmd = gitsigns.stage_buffer,
          keys = { "n", "<s-S>" },
        },
        {
          desc = "Preview hunk",
          cmd = gitsigns.preview_hunk,
          keys = { "n", "K" },
        },
        {
          desc = "View line blame",
          cmd = gitsigns.blame_line,
          keys = { "n", "B" },
        },
        {
          desc = "Toggle deleted",
          cmd = gitsigns.toggle_deleted,
          keys = { "n", "<c-d>" },
        },
        {
          desc = "View line blame (full)",
          cmd = function()
            gitsigns.blame_line({ full = true })
          end,
          keys = { "n", "<c-b>" },
        },
        {
          desc = "send git hunks to location list",
          cmd = gitsigns.setloclist,
        },
        {
          desc = "Send git hunks to quick fix list",
          cmd = gitsigns.setqflist,
        },
      })
    end

    if fn.require("neogit") then
      vim.list_extend(commands, {
        {
          desc = "Open neogit",
          cmd = "<CMD>Neogit<CR>",
          keys = { "n", "ng" },
        },
      })
    end

    if fn.require("diffview") then
      vim.list_extend(commands, {
        {
          desc = "Open diffview",
          cmd = "<CMD>DiffviewOpen<CR>",
          keys = { "n", "dv" },
        },
        {
          desc = "Open file commit history panel",
          cmd = "<CMD>DiffviewFileHistory<CR>",
          keys = { "n", "df" },
        },
        {
          desc = "Open file commit history panel",
          cmd = "<CMD>DiffviewFileHistory %<CR>",
          keys = { "n", "d%" },
        },
        {
          desc = "Close diffview/file commit history panel",
          cmd = "<CMD>DiffviewClose<CR>",
          keys = { "n", "q" },
        },
      })
    end

    return commands
  end,
}
