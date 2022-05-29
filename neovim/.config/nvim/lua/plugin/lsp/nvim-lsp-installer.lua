return {
  "williamboman/nvim-lsp-installer",

  config = function()
    local nvim_lsp_installer = require("nvim-lsp-installer")

    nvim_lsp_installer.setup({
      -- Automatically install servers configured by lspconfig
      automatic_installation = true,
    })

  end,

  -- TODO: Remove this when head is fixed
  commit = "3c21304c3f54caf0c00fab00cf1e4e9c0507b5d1"
}
