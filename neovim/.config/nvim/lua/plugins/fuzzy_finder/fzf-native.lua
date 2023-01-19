return {
  "nvim-telescope/telescope-fzf-native.nvim",

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  build = "make",

  config = function()
    require("telescope").load_extension("fzf")
  end,
}
