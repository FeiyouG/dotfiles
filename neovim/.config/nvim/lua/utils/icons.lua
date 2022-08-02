local M = {
  exit = "",
  enter = "",
  layout = "◧",
}

M.file = {
  default = '',
  symlink = '',
}

M.folder = {
  open_indictor = "−",
  closed_indicator = "+",
  open = "",
  closed = "",
  empty_open = "",
  empty_closed = "",
  symlink_open = "",
  symlink_closed = "",
}

M.git = {
  git = "",
  unstaged = "✗",
  staged = "✓",
  unmerged = "",
  renamed = "",
  untracked = "",
  deleted = "",
  ignored = "◌"
}

M.diagnostic = {
  error = "",
  warning = "",
  hint = "",
  info = "",
  other = "﫠"
  -- hint = "",
  -- info = "",
  -- warning = "",
  -- error = "",
}

M.border = {
  rounded = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
  },

}

return M
