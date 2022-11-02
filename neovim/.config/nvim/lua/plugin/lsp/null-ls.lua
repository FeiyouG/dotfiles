return {
  'jose-elias-alvarez/null-ls.nvim',

  requires = { 'nvim-lua/plenary.nvim' },

  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- MARK: Formatter
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier.with({
          filetype = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "html", "json", "jsonc",
            "yaml" }
        }),
        null_ls.builtins.formatting.stylua,
      }
    })
  end
}
