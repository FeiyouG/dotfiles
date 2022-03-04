---- MARK: Restore Last Cursor Position ----
vim.api.nvim_exec([[
  augroup RestoreCursorPosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
  augroup END
]], false)


---- MARK: Trim Trailling Whitespaces ----
vim.api.nvim_exec([[
  augroup TrimWhiteSpace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END
]], false)


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

