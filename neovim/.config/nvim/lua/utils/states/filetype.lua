local M = {}

---File types added to this list can be quited when pressing `q` in normal mode
M.quit_on_q = {
  ft = {},
  add = function(self, ...)
    if not ... then return end
    vim.list_extend(self.ft, { ... })
  end
}

require("utils.fn").add_commands({
  {
    desc = "Quit file on q",
    cmd = function()
      require("Utils.fn").P(M.quit_on_q)
      local bf = vim.api.nvim_get_current_buf()
      local filetype = vim.api.nvim_buf_get_option(bf, "filetype")
      if vim.tbl_contains(M.quit_on_q.ft, filetype) then
        vim.cmd("quit!")
      end
    end,
    keys = { "n", "q" },
    mode = require("utils.constants").keymap.cc_mode.SET
  }
})

return M
