---- MARK: Restore Last Cursor Position ----
vim.api.nvim_exec([[
  augroup RestoreCursorPosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
  augroup END
]], false)


---- MARK: Trim Trailling Whitespaces ----
local trimWhiteSpace = vim.api.nvim_create_augroup("TrimWhiteSpace", {clear = true})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  callback = function()
    if not vim.o.binary and vim.o.filetype ~= 'diff' and vim.bo.modifiable then
      vim.cmd([[%s/\s\+$//e]])
    end
  end,
  group = trimWhiteSpace
})

---- MARK: Automatically Switch Between Relative and Asbolute Line Number ----
vim.api.nvim_exec([[
  augroup ToggleLineNumInsert
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
  augroup END
]], false)

vim.api.nvim_exec([[
  augroup ToggleLineNumFocus
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]], false)

