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
}
