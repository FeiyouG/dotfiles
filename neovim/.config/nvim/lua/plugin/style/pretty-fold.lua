return {
  'anuvyklack/pretty-fold.nvim',

  config = function()
    local pretty_fold = require("pretty-fold")

    -- Set common config
    pretty_fold.setup({
      sections = {
        left = {
          'content',
        },
        right = {
          ' ', 'number_of_folded_lines', ' (', 'percentage', ') ',
          function(config) return config.fill_char:rep(3) end
        }
      },
      fill_char = '•',

      remove_fold_markers = true,

      -- Keep the indentation of the content of the fold string.
      keep_indentation = true,

      process_comment_signs = 'spaces',

      -- Comment signs additional to the value of `&commentstring` option.
      comment_signs = {},

      -- List of patterns that will be removed from content foldtext section.
      stop_words = {
        '@brief%s*', -- (for C++) Remove '@brief' and all spaces after.
      },

      add_close_pattern = true, -- true, 'last_line' or false

      matchup_patterns = {
        { '^%s*do$', 'end' }, -- do ... end blocks
        { '^%s*if', 'end' }, -- if ... end
        { '^%s*for', 'end' }, -- for
        { 'function%s*%(', 'end' }, -- 'function( or 'function (''
        { '{', '}' },
        { '%(', ')' }, -- % to escape lua pattern char
        { '%[', ']' }, -- % to escape lua pattern char
      },

      ft_ignore = { 'neorg' },


    })
  end
}
