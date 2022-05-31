return {
  adapters = {
    type = "executable",
    command = vim.fn.glob "$XDG_DATA_HOME/virtualenvs/debugpy/bin/python",
    -- command = ".config/virtualenvs/debugpy".
    args = { "-m", "debugpy.adapter" }
  },
  configurations = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",

      program = "${file}",
      -- pythonPath = function()
      --   local cwd = vim.fn.getcwd()
      --   if vim.fn.executable(cwd .. "/usr/bin/python3.9") == 1 then
      --     return cwd .. "/usr/bin/python3.9"
      --   elseif vim.fn.executable(cwd .. "/usr/bin/python3.9") == 1 then
      --     return cwd .. "/usr/bin/python3.9"
      --   else
      --     return "/usr/bin/python3.9"
      --   end
      -- end
    }
  }
}
