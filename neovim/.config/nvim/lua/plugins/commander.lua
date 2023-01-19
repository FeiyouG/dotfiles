return {
  "git@github.com:FeiyouG/command_center.nvim.git",

  dev = true,

  lazy = false,

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    local commander = require("commander")
    commander.setup({
      components = {
        commander.component.DESC,
        commander.component.KEYS,
        commander.component.CAT,
      },
      sort_by = {
        commander.component.DESC,
        commander.component.CAT,
        commander.component.KEYS,
        commander.component.CMD,
      },
      auto_replace_desc_with_cmd = true,
      telescope = {
        integrate = true,
        theme = require("telescope.themes").commander,
      },
    })

    require("settings.fn").keymap.set({
      {
        desc = "Open Commander",
        cmd = "<CMD>Telescope commander<CR>",
        keys = {
          -- If ever hesitate when using telescope start with <leader>f,
          -- also open command center
          { { "n", "x" }, "<Leader>f" },
          { { "n", "x" }, "<Leader>fc" },
        },
      },
    })
  end,

  -- commands = function()
  --   local keymap = Utils.keymap
  --
  --   return {
  --     {
  --       description = "Open Commander",
  --       cmd = "<CMD>Telescope commander<CR>",
  --       keybindings = {
  --         -- If ever hesitate when using telescope start with <leader>f,
  --         -- also open command center
  --         { "n", "<Leader>f", keymap.noremap },
  --         { "x", "<Leader>f", keymap.noremap },
  --       },
  --     },
  --   }
  -- end,
}
