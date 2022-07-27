return {
  'git@github.com:FeiyouG/command_center.nvim.git',

  config = function()
    local command_center = require("command_center")

    -- Integrate with telescope
    local has_telescope, telescope = pcall(require, "telescope")
    if has_telescope then
      telescope.setup {
        extensions = {
          command_center = {
            components = {
              command_center.component.DESCRIPTION,
              command_center.component.KEYBINDINGS,
            },
            sort_by = {
              command_center.component.DESCRIPTION,
              command_center.component.KEYBINDINGS,
            },
            auto_replace_desc_with_cmd = false,
          }
        }
      }

      telescope.load_extension('command_center')
    end
  end,

  commands = {
    {
      description = "Open command_center",
      cmd = "<CMD>Telescope command_center<CR>",
      keybindings = {
        { "n", "?", require("utils").keymap.noremap },
        { "v", "?", require("utils").keymap.noremap },

        -- If ever hesitate when using telescope start with <leader>f,
        -- also open command center
        { "n", "<Leader>f", require("utils").keymap.noremap },
        { "v", "<Leader>f", require("utils").keymap.noremap },
      },
    }
  }
}
