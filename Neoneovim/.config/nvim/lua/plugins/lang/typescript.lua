return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.tsserver = {}
      return opts
    end,
  }
}