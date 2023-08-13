return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.jsonls = {}
      return opts
    end,
  }
}
