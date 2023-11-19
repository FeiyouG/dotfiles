local emmet_ft = {
  "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss",
  "svelte", "pug", "typescriptreact", "vue"
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)

      -- For Vue
      opts.volar = {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      }

      -- For emmet integrations
      opts.emmet_language_server = {
        filetypes = emmet_ft
      }
      return opts
    end,
  },
  {
    "olrtg/nvim-emmet",
    ft = emmet_ft,
    --   keys = {
    --     {
    --       "<localleader>ge",
    --       function()
    --         require('nvim-emmet').wrap_with_abbreviation()
    --       end,
    --       desc = "Wrap with emmet",
    --       mode = { "n", "v" }
    --     }
    --   },
    commander = {
      {
        desc = "Wrap with emmet",
        cmd = function()
          require('nvim-emmet').wrap_with_abbreviation()
        end,
        keys = { { "n", "v" }, "<localleader>ge" }

      }
    }
  },
}
