local M = {}

M.file = {
  buffer = "",
  default = '',
  symlink = '',
}

M.folder = {
  indicator_open = "−",
  indicator_closed = "+",
  closed = "",
  open = "",
  empty_closed = "",
  empty_open = "",
  symlink_closed = "",
  symlink_open = "",
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

M.misc = {
  exit = "",
  entet = "",
}

return M
