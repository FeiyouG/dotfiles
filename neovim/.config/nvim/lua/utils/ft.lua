local M = {}

M.special_buf = {
  'nofile',
  'quickfix',
  'prompt'
}

M.add_special_buf = function(...)
  if not ... then return end
  vim.list_extend(M.special_buf, { ... })
end


-- MARK: Quit on q
M.quit_on_q = {}

M.add_quit_on_q = function(...)
  if not ... then return end
  vim.list_extend(M.quit_on_q, { ... })
end

local QuitOnQ = vim.api.nvim_create_augroup("QuitOnQ", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  callback = function()
    local ft = vim.api.nvim_buf_get_option(0, "filetype")

    if vim.tbl_contains(M.quit_on_q, ft) then
      require("utils.fn").add_commands({
        {
          desc = "Quit " .. ft .. " buffer on q",
          cmd = function()
            vim.cmd("quit!")
          end,
          keys = {
            { "n", "q" },
            { "v", "q" },
          },
          mode = require("utils.keymap").cc_mode.SET
        }
      }, {
        keys_opts = { buffer = true }
      })
    end
  end,
  group = QuitOnQ
})

return M
