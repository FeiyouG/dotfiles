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

  defer = function()
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    local noremap = { noremap = true }

    command_center.add({
      {
        cmd = "<CMD>OSCYank<CR>",
        keybindings = {"v", "<leader>y", noremap}
      }, {
        cmd = "<plug>OSCYank",
        keybindings = {"v", "<leader>y", {}}
      }
    }, command_center.mode.registger_only)
  end
}
