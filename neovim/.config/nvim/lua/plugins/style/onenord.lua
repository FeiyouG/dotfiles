return {
  "rmehri01/onenord.nvim",

  lazy = false,
  priority = 1000,

  config = function()
    local colors = require("onenord.colors").load()

    require("onenord").setup({
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
        -- Editor
        WinSeparator = { fg = colors.blue, bg = colors.active },

        -- Override for nvim-cmp
        CmpItemAbbrMatch = { fg = colors.yellow, style = "bold" },
        CmpItemAbbrMatchFuzzy = { fg = colors.yellow, underline = true },

        -- Override for git sign
        GitSignsAddLn = { bg = colors.diff_add_bg },
        GitSignsChangeLn = { bg = colors.diff_change_bg },
        GitSignsDeleteLn = { bg = colors.diff_remove_bg },

        -- For nvim-dap
        DapBreakpoint = { fg = colors.diff_change, bg = colors.diff_change_bg },
        DapBreakpointCondition = { fg = colors.diff_change, bg = colors.diff_change_bg },
        DapBreakpointRejected = { fg = colors.diff_remove, bg = colors.diff_remove_bg },
        DapLogPoint = { fg = colors.yellow, bg = colors.yellow_bg },
        DapStopped = { fg = colors.diff_add, bg = colors.diff_add_bg },

        -- nvim-ufo
        UfoFoldedBg = { fg = colors.gray, bg = colors.none, style = "underline" },
        UfoFoldedEllipsis = { fg = colors.light_gray, style = "italic" },
      },
      custom_colors = {
        yellow_bg = "#947e50",
      },
    })
  end,
}
