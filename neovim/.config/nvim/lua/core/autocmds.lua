local M = {}
local state = require("settings.state")

--------------------------------------------------------------------------------
-- Restore Last Cursor Position
local restore_cursor_position = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" },
  callback = function()
    -- Marks are (1,0) indexed
    local cursor_pos = vim.api.nvim_buf_get_mark(0, '"')
    if cursor_pos[1] >= 0 and cursor_pos[1] <= 0 then
      vim.api.nvim_cmd("normal! g'\"")
    end
  end,
  group = restore_cursor_position,
})

--------------------------------------------------------------------------------
---- Automatically Switch Between Relative and Asbolute Line Number ----
local toggle_line_number_on_insert = vim.api.nvim_create_augroup("ToggleLineNumberOnInsert", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.number._value then
      vim.opt.relativenumber = false
    end
  end,
  group = toggle_line_number_on_insert,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.number._value then
      vim.opt.relativenumber = true
    end
  end,
  group = toggle_line_number_on_insert,
})

local toggle_line_number_on_focus = vim.api.nvim_create_augroup("ToggleLineNumberOnFocus", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.number._value then
      vim.opt.relativenumber = true
    end
  end,
  group = toggle_line_number_on_focus,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.number._value then
      vim.opt.relativenumber = false
    end
  end,
  group = toggle_line_number_on_focus,
})

--------------------------------------------------------------------------------
-- Quit on 'q'

local quit_on_q = vim.api.nvim_create_augroup("QuitOnQ", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  callback = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")

    if state.quit_on_q.contains_ft(ft) then
      vim.keymap.set({ "n", "v" }, "q", vim.cmd.close, { desc = "Close " .. ft .. " buffer" })
    end
  end,
  group = quit_on_q,
})
