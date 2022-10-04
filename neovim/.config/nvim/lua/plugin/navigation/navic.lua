return {
  'SmiteshP/nvim-navic',

  requires = {
    "neovim/nvim-lspconfig"
  },

  config = function()
    local navic = require("nvim-navic")
    navic.setup {
      icons = Utils.icons.lsp,
      highlight = false,
      separator = " ❯ ",
      depth_limit = 3,
      depth_limit_indicator = "…",
    }
  end
}
