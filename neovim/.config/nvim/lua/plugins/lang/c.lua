return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", }, -- Exclude protobuf
        cmd = {
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--clang-tidy=false",
          "--completion-style=detailed",
          "--pch-storage=memory",
        },
      }
      return opts
    end,
  },
}
