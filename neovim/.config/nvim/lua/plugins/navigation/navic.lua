return {
  'SmiteshP/nvim-navic',

  event = { "VeryLazy" },

  dependencies = {
    "neovim/nvim-lspconfig"
  },

  config = function()
    local navic = require("nvim-navic")
    local style = require("settings.style")
    navic.setup {
      icons = style.icons.lsp,
      lsp = {
        auto_attach = true,
        preference = nil,
      },
      highlight = false,
      separator = " ❯ ",
      depth_limit = 3,
      depth_limit_indicator = "…",
      safe_output = true,
    }
  end
}
