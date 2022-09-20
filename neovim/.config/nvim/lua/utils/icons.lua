local M = {
  exit = " ",
  enter = " ",
  layout = " ",
  symbolic_arrow = " ﰣ "
}

M.file = {
  default = ' ',
  symlink = ' ',
}

M.folder = {
  open_indictor = "−",
  closed_indicator = "+",
  folders = " ",
  open = " ",
  closed = " ",
  empty_open = " ",
  empty_closed = " ",
  symlink_open = " ",
  symlink_closed = " ",
}

M.git = {
  git = " ",
  unstaged = " ",
  staged = " ",
  unmerged = " ",
  renamed = " ",
  untracked = " ",
  deleted = " ",
  ignored = " ",
  modified = " ",
  added = " "
}

M.diagnostic = {
  diagnostics = " ",
  -- error = " ",
  -- warning = " ",
  -- hint = " ",
  -- info = " ",
  -- other = "﫠"
  error = " ",
  warning = " ",
  info = " ",
  hint = " ",
  other = " "
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
