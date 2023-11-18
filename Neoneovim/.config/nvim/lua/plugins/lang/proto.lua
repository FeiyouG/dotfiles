return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = {
      require("null-ls").builtins.formatting.buf,
      require("null-ls").builtins.diagnostics.protolint,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.bufls = {}
      return opts
    end,
  },
}
