return {
 "rmehri01/onenord.nvim",

  config = function()

    require('onenord').setup {
      theme = "dark",
      fade_nc = false,
      styles = {
        comments = "italic",
        diagnostics = "undercurl",
      }
    }

  end
}
