return {
  "rmehri01/onenord.nvim",

  config = function()

    local colors = require("onenord.colors").load()

    require('onenord').setup {
      theme = "dark",
      fade_nc = false,
      styles = {
        comments = "italic",
        diagnostics = "undercurl",
      },
      inverse = {
        match_paren = false,
      },
      custom_highlights = {
        CmpItemAbbrMatch = { fg = colors.yellow, style = "bold" },
        CmpItemAbbrMatchFuzzy = { fg = colors.yellow, underline = true },
      }
    }

  end
}
