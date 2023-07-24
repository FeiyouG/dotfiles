local M = {}
_G.settings.ft = M

-- Augroup for all autocmds created in the module
local ft_augroup = vim.api.nvim_create_augroup("Settings.ft", { clear = true })

local function buffer_matches(patterns, bufnr)
  bufnr = bufnr or 0

  local buf_matchers = {
    filetype = function()
      return vim.bo[bufnr].filetype
    end,
    buftype = function()
      return vim.bo[bufnr].buftype
    end,
    bufname = function()
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
    end,
  }

  for kind, pattern_list in pairs(patterns) do
    if vim.tbl_contains(pattern_list, buf_matchers[kind]()) then
      return true
    end
  end
  return false
end

-- MARK: Winbar
M.exclude_winbar = {
  filetype = {},
  buftype = {
    "help",
  },
  bufname = {},
}

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufWinEnter", "FileType", "TermOpen" }, {
  pattern = { "*" },
  callback = function()
    if buffer_matches(M.quit_on_q, 0) then
      vim.opt_local.winbar = nil
      vim.wo.winbar = nil
    end
  end,
  group = ft_augroup,
})

-- MARK: Quit on Q
M.quit_on_q = {
  buftype = {
    "nofile",
    "quickfix",
    "prompt",
  },
  filetype = {},
  bufname = {},
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  callback = function()
    if buffer_matches(M.quit_on_q, 0) then
      vim.keymap.set({ "n", "v" }, "q", vim.cmd.close, { desc = "Close current buffer", buffer = true })
    end
  end,
  group = ft_augroup,
})
