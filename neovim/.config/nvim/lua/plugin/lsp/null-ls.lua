return {
  "jose-elias-alvarez/null-ls.nvim",

  requires = { "nvim-lua/plenary.nvim" },

  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- MARK: Golang
        -- null_ls.builtins.diagnostics.revive,
        null_ls.builtins.formatting.gofumpt,

        -- MARK: Lua
        null_ls.builtins.formatting.stylua,

        -- MARK: Python
        -- null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,

        -- MARK: Javascript
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
