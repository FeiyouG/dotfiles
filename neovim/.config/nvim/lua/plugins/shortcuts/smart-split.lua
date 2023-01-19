return {
  "mrjones2014/smart-splits.nvim",

  config = function()
    local smart_split = require("smart-splits")

    smart_split.setup({
      -- Ignored filetypes (only while resizing)
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "prompt",
        "TelescopePrompt",
      },
      -- Ignored buffer types (only while resizing)
      ignored_buftypes = {},

      -- the default number of lines/columns to resize by at a time
      default_amount = 3,

      -- when moving cursor between splits left or right,
      -- place the cursor on the same row of the *screen*
      -- regardless of line numbers. False by default.
      -- Can be overridden via function parameter, see Usage.
      move_cursor_same_row = false,

      -- resize mode options
      resize_mode = {
        -- key to exit persistent resize mode
        quit_key = "<ESC>",
        -- keys to use for moving in resize mode
        -- in order of left, down, up' right
        resize_keys = { "h", "j", "k", "l" },
        -- set to true to silence the notifications
        -- when entering/exiting persistent resize mode
        silent = false,
        -- must be functions, they will be executed when
        -- entering or exiting the resize mode
        hooks = {
          on_enter = nil,
          on_leave = nil,
        },
      },
      -- ignore these autocmd events (via :h eventignore) while processing
      -- smart-splits.nvim computations, which involve visiting different
      -- buffers and windows. These events will be ignored during processing,
      -- and un-ignored on completed. This only applies to resize events,
      -- not cursor movement events.
      ignored_events = {
        "BufEnter",
        "WinEnter",
      },
      -- enable or disable the tmux integration
      tmux_integration = true,
    })

    local commander = require("settings.fn").require("commander")
    if commander then
      commander.add({
        {
          desc = "Resize window up",
          cmd = smart_split.resize_up,
          keys = { "n", "<M-k>" },
        },
        {
          desc = "Resize window down",
          cmd = smart_split.resize_down,
          keys = { "n", "<M-j>" },
        },
        {
          desc = "Resize window left",
          cmd = smart_split.resize_left,
          keys = { "n", "<M-h>" },
        },
        {
          desc = "Resize window right",
          cmd = smart_split.resize_right,
          keys = { "n", "<M-l>" },
        },
        {
          desc = "Move to window up",
          cmd = smart_split.move_cursor_up,
          keys = { "n", "<C-k>" },
        },
        {
          desc = "Move to window down",
          cmd = smart_split.move_cursor_down,
          keys = { "n", "<C-j>" },
        },
        {
          desc = "Move to window left",
          cmd = smart_split.move_cursor_left,
          keys = { "n", "<C-h>" },
        },
        {
          desc = "Move to window right",
          cmd = smart_split.move_cursor_right,
          keys = { "n", "<C-l>" },
        },
      }, {
        mode = commander.mode.SET,
      })
    end
  end,
}
