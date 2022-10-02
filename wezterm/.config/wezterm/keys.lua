local wezterm = require('wezterm')
local action = wezterm.action

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, _)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

return {
  use_dead_keys = false,
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    {
      key = 'p',
      mods = 'LEADER',
      action = action.ActivateKeyTable {
        name = 'pane_management',
        one_shot = false,
        until_unknown = true,
      },
    },

    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    -- Select panes without enter keytable
    {
      key = 'h',
      mods = 'LEADER',
      action = action.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = action.ActivatePaneDirection 'Right',
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = action.ActivatePaneDirection 'Down',
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = action.ActivatePaneDirection 'Up',
    },

  },

  key_tables = {
    pane_management = {
      -- Select panes
      { key = 'h', action = action.ActivatePaneDirection 'Left' },
      { key = 'l', action = action.ActivatePaneDirection 'Right' },
      { key = 'k', action = action.ActivatePaneDirection 'Up' },
      { key = 'j', action = action.ActivatePaneDirection 'Down' },

      -- Resize panes
      { key = 'h', mods = 'ALT', action = action.AdjustPaneSize { 'Left', 1 } },
      { key = 'l', mods = 'ALT', action = action.AdjustPaneSize { 'Right', 1 } },
      { key = 'j', mods = 'ALT', action = action.AdjustPaneSize { 'Up', 1 } },
      { key = 'k', mods = 'ALT', action = action.AdjustPaneSize { 'Down', 1 } },

      -- Cancel the mode by pressing escape
      { key = 'q', action = 'PopKeyTable' },
      { key = 'Escape', action = 'PopKeyTable' },
    },
  },
}
