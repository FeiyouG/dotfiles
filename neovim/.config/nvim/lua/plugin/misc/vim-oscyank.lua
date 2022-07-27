return {
  'ojroques/vim-oscyank',

  config = function()
    -- Use osc52 as neovim's clipboard provider
    local function copy(lines, _)
      vim.fn.OSCYankString(table.concat(lines, "\n"))
    end

    local function paste()
      return {
        vim.fn.split(vim.fn.getreg(''), '\n'),
        vim.fn.getregtype('')
      }
    end

    vim.g.clipboard = {
      name = "osc52",
      copy = {
        ["+"] = copy,
        ["*"] = copy
      },
      paste = {
        ["+"] = paste,
        ["*"] = paste
      }
    }
  end,

  commands = function()
    local utils = require("utils")

    return {
      {
        cmd = "<CMD>OSCYank<CR>",
        keybindings = {"v", "<leader>y", utils.keymap.noremap},
        mode = utils.keymap.cc_mode.registger_only,
      }, {
        cmd = "<plug>OSCYank",
        keybindings = {"v", "<leader>y", {}},
        mode = utils.keymap.cc_mode.registger_only,
      }
    }
  end
}
