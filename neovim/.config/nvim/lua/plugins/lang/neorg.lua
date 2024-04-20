return {
  {
    "nvim-neorg/neorg",
    run = ":Neorg sync-parsers",
    ft = { "norg" },
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.export"] = { config = { export_dir = "~/Downloads" } },
          ["core.dirman"] = { config = { workspaces = { notes = "~/Notes", }, } },
          ["core.completion"] = { config = { engine = "nvim-cmp" } },
          ["core.summary"] = {},
        },
      }
    end,
  },
}
