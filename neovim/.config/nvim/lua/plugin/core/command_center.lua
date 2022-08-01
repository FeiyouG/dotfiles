return {
  'git@github.com:FeiyouG/command_center.nvim.git',

  requires = {
    'nvim-telescope/telescope.nvim',
  },

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
            auto_replace_desc_with_cmd = true,
          }
        }
      }

      telescope.load_extension('command_center')
    end
  end,

  commands = function()
    local keymap = Utils.keymap

    return {
      {
        description = "Open command_center",
        cmd = "<CMD>Telescope command_center<CR>",
        keybindings = {
          { "n", "?", keymap.noremap },
          { "v", "?", keymap.noremap },

          -- If ever hesitate when using telescope start with <leader>f,
          -- also open command center
          { "n", "<Leader>f", keymap.noremap },
          { "v", "<Leader>f", keymap.noremap },
        },
      }
    }
  end

}
