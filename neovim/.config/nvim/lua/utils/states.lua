local M = {}

-- MARK: Filtypes
local quit_on_q = {}

M.ft = {
  quit_on_q = {
    add = function(...)
      if not ... then return end
      vim.list_extend(quit_on_q, { ... })
    end
  }
}

require("utils.fn").add_commands({
  {
    desc = "Quit file on q",
    cmd = function()
      local bf = vim.api.nvim_get_current_buf()
      local filetype = vim.api.nvim_buf_get_option(bf, "filetype")
      if vim.tbl_contains(quit_on_q, filetype) then
        vim.cmd("quit!")
      end
    end,
    keys = {
      { "n", "q" },
      { "v", "q" },
    },
    mode = require("utils.keymap").cc_mode.SET
  }
})

return M
