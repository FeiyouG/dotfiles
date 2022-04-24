return {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    config = function() require('telescope').load_extension('fzf') end
  }

