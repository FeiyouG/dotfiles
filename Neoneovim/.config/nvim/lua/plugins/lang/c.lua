return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.clangd = {}
      return opts
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "c",
        "cpp",
      })
      return opts
    end,
  },
}
