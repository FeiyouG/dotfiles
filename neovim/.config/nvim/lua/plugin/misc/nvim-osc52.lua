return {
  'ojroques/nvim-osc52',

  config = function()
    -- Use osc52 as neovim's clipboard provider
    -- local function copy(lines, _)
    --   require('osc52').copy(table.concat(lines, '\n'))
    -- end
    --
    -- local function paste()
    --   return {
    --     vim.fn.split(vim.fn.getreg(''), '\n'),
    --     vim.fn.getregtype('')
    --   }
    -- end
    --
    -- vim.g.clipboard = {
    --   name = 'osc52',
    --   copy = {
    --     ['+'] = copy,
    --     ['*'] = copy
    --   },
    --   paste = {
    --     ['+'] = paste,
    --     ['*'] = paste
    --   },
    -- }
    --
    -- -- Now the '+' register will copy to system clipboard using OSC52
    -- vim.keymap.set('n', '<leader>c', '"+y')
    -- vim.keymap.set('n', '<leader>cc', '"+yy')
  end,

  commands = function()
    return {
      {
        cmd = require('osc52').copy_operator,
        keys = { "n", "<leader>y", Utils.keymap.expr },
        mode = Utils.keymap.cc_mode.SET,
      }, {
        cmd = require('osc52').copy_visual,
        keys = { "v", "<leader>y" },
        mode = Utils.keymap.cc_mode.SET,
      }
    }
  end

}
