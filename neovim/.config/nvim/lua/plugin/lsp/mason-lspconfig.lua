return {
  "williamboman/mason-lspconfig.nvim",

  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
      -- This setting has no relation with the `automatic_installation` setting.
      ensure_installed = { "jdtls@1.12.0-202206011637" },

      -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Servers are not automatically installed.
      --   - true: All servers set up via lspconfig are automatically installed.
      --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      automatic_installation = { exclude = { "jdtls" } }
    })
  end
}