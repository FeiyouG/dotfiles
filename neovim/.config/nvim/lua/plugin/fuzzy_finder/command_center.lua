local M = {
  'git@github.com:FeiyouG/command_center.nvim.git',
}

M.config = function()
  local command_center = require("command_center")
  local noremap = { noremap = true }

  command_center.add({
    {
      description = "Open command_center",
      command = "Telescope command_center",
      keybindings = {
        {"n", "<Leader>fc", noremap},
        {"v", "<Leader>fc", noremap},

        -- If ever hesitate when using telescope start with <leader>f,
        -- also open command center
        {"n", "<Leader>f", noremap},
        {"v", "<Leader>f", noremap},
      },
    }
  }, command_center.mode.REGISTER_ONLY)

  -- Integrate with telescope
  local has_telescope, telescope = pcall(require, "telescope")
  if has_telescope then
    telescope.setup {
      extensions = {
        command_center = {
          components = {
            command_center.component.DESCRIPTION,
            command_center.component.KEYBINDINGS,
            -- command_center.component.COMMAND,
          },
          auto_replace_desc_with_cmd = false,
        }
      }
    }

    telescope.load_extension('command_center')
  end
end


return M
