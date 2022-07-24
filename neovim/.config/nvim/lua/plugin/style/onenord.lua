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
        -- Override for nvim-cmp
        CmpItemAbbrMatch = { fg = colors.yellow, style = "bold" },
        CmpItemAbbrMatchFuzzy = { fg = colors.yellow, underline = true },

        -- Override for git sign
        GitSignsAddLn = { bg = colors.diff_add_bg },
        GitSignsChangeLn = { bg = colors.diff_change_bg },
        GitSignsDeleteLn = { bg = colors.diff_remove_bg },
}
    }

  end
}
