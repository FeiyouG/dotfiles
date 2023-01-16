return {
  "dhruvasagar/vim-table-mode",

  ft = { "markdown" },

  config = function()
    vim.cmd("let g:table_mode_corner='|'")
  end,
}
