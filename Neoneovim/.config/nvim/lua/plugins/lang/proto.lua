return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      return vim.list_extend(opts, {
        require("null-ls").builtins.formatting.buf,
        require("null-ls").builtins.diagnostics.protolint,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.bufls = {}
      return opts
    end,
  },
}
