return {
  "williamboman/nvim-lsp-installer",

  config = function()
    local nvim_lsp_installer = require("nvim-lsp-installer")

    nvim_lsp_installer.setup({
      -- Download the specific version of jdtls (the neweset one is not working currently)
      ensure_installed = { "jdtls@1.12.0-202206011637" },

      -- Automatically install servers configured by lspconfig (expect jdtls, because we want a specific version)
      automatic_installation = { exclude = { "jdtls" } }
    })

  end,

  -- TODO: Remove this when head is fixed
  commit = "3c21304c3f54caf0c00fab00cf1e4e9c0507b5d1"
}
