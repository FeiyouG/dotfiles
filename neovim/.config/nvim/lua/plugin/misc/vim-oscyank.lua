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
        keys = { "v", "<leader>y", Utils.constants.keymap.noremap },
        mode = Utils.constants.keymap.cc_mode.REGISTER_ONLY,
      }, {
        cmd = "<plug>OSCYank",
        keys = { "v", "<leader>y", Utils.constants.keymap.noremap },
        mode = Utils.constants.keymap.cc_mode.REGISTER_ONLY,
      }
    }
  end
}
