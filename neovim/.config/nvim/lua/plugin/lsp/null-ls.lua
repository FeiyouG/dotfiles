return {
  "jose-elias-alvarez/null-ls.nvim",

  requires = { "nvim-lua/plenary.nvim" },

  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- MARK: diagnostics
        -- null_ls.builtins.diagnostics.revive, -- Go

        -- MARK: Formatter
        null_ls.builtins.formatting.isort,   -- Python
        null_ls.builtins.formatting.black,   -- Python
        null_ls.builtins.formatting.stylua,  -- Lua
        null_ls.builtins.formatting.gofumpt, -- Go
        null_ls.builtins.formatting.prettier.with({
          filetype = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "css",
            "html",
            "json",
            "jsonc",
            "yaml",
          },
        }),
      },
    })
  end,
}
