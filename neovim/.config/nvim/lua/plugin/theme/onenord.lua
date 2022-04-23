local M = {
  "rmehri01/onenord.nvim"
}

M.config = function()
  require('onenord').setup {
    theme = "dark",
    fade_nc = false,
    styles = {
      comments = "italic",
      diagnostics = "undercurl",
    }
  }
end

return M
