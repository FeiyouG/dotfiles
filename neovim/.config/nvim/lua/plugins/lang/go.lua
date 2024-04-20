return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      return vim.list_extend(opts, {
        require("null-ls").builtins.formatting.gofumpt,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.gopls = {
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod" },
        root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      }
      return opts
    end,
  },
  {
    "ray-x/go.nvim",
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    dependencies = {                                        -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
  }

}
