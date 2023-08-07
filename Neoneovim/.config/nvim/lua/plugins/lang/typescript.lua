return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.tsserver = {}
      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "typescript",
      })
      return opts
    end,
  },
}
