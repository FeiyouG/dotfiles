return {
  "numToStr/Comment.nvim",

  config = function()
    local comment = require("Comment")

    comment.setup {
      ---LHS of toggle mappings in NORMAL + VISUAL mode
      ---@type table
      toggler = {
        ---Line-comment toggle keymap
        line = '<leader>cc',
        ---Block-comment toggle keymap
        block = '<leader>/',
      },
      ---LHS of operator-pending mappings in NORMAL + VISUAL mode
      ---@type table
      opleader = {
        ---Line-comment keymap
        line = '<leader>c',
        ---Block-comment keymap
        block = '<leader>/',
      },

      ---LHS of extra mappings
      ---@type table
      extra = {
        ---Add comment on the line above
        above = '<leader>cO',
        ---Add comment on the line below
        below = '<leader>co',
        ---Add comment at the end of line
        eol = '<leader>cA',
      },

      ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      ---@type table
      mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = true,
        ---Extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = true,
      },

    }

    local ft = require('Comment.ft')

    ft.javascript = { '//%s', '/**%s*/' }
  end,
}
