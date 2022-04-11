local comment = require("Comment")
local command_center = require("command_center")

-- Don't register the keybindings
-- since it has been registed by comment.nvim
command_center.add({
  {
    description = "Toggle comment on current line",
    command = "lua require('comment.api').toggle_current_linewise(cfg)",
    keybindings = { "n", "<leader>cc"},
  }, {
    description = "Toggle comment on current selection",
    command = "lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())",
    keybindings = { "v", "<leader>c"},
  }, {
    description = "Toggle block comment on current selection",
    command = "lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())",
    keybindings = { "v", "<leader>c"},
  },

}, command_center.mode.ADD_ONLY)


comment.setup {
  ---LHS of toggle mappings in NORMAL + VISUAL mode
  ---@type table
  toggler = {
      ---Line-comment toggle keymap
      line = '<leader>cc',
      ---Block-comment toggle keymap
      block = '<leader>bc',
  },
  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
      ---Line-comment keymap
      line = '<leader>c',
      ---Block-comment keymap
      block = '<leader>b',
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

ft.javascript = {'//%s', '/**%s*/'}
