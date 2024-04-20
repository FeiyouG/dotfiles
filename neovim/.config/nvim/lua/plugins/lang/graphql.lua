return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local util = require("lspconfig").util

      opts.graphql = {
        filetypes = { "graphql", "graphqls", "typescriptreact", "javascriptreact" },
        root_dir = util.root_pattern(
          '.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*',
          'gqlgen.yml'     -- gqlgen in golang
        )

      }
      return opts
    end,
  },
}
