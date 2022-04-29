return {
  "williamboman/nvim-lsp-installer",

  config = function()
    local nvim_lsp_installer = require("nvim-lsp-installer")

    nvim_lsp_installer.setup({
      -- Automatically install servers configured by lspconfig
      automatic_installation = true,
    })

  end
}
