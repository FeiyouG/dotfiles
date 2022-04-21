return {
  require("plugin/fuzzy_finder/telescope"),

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    config = function() require('telescope').load_extension('fzf') end
  },

  require("plugin/fuzzy_finder/command_center")
}
