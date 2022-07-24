local filter_git_commands = function()
  local has_command_center, command_center = pcall(require, "command_center")
  if not has_command_center then return end

  local noremap = { noremap = true }
  command_center.add({
    {
      description = "Command center for git",
      cmd = "<CMD>Telescope command_center category=git<CR>",
      keybindings = {
        { "n", "<leader>g", noremap },
        { "v", "<leader>g", noremap },
      },
      mode = command_center.mode.REGISTER_ONLY
    }
  })
end

filter_git_commands()

return {
  -- require("plugin/integration/git/fugitive"),
  require("plugin/git/diffview"),
  require("plugin/git/gitsigns"),
  require("plugin/git/neogit"),
  { "tpope/vim-fugitive" },
}
