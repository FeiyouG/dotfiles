return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", } -- Exclude protobuf
      }
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
