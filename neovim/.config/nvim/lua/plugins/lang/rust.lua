return {
  {
    -- Automatically set up rust-analyzer, no need for lspconfig
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = settings.fn.lsp.on_attach,
        }
      }
    end
  },

  {
    -- So we need to ensure rust-analyzer is installed
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "rust_analyzer"
      })
      return opts
    end
  }
}
