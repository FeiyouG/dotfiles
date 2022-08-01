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
    return {
      {
        cmd = "<CMD>OSCYank<CR>",
        keys = { "v", "<leader>y", Utils.keymap.noremap },
        mode = Utils.keymap.cc_mode.SET,
      }, {
        cmd = "<plug>OSCYank",
        keys = { "v", "<leader>y", Utils.keymap.noremap },
        mode = Utils.keymap.cc_mode.SET,
      }
    }
  end
}
