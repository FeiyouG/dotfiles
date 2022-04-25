return {
  'tpope/vim-fugitive',

  defer = function()
    local has_command_center, command_center = pcall(require, "command_center")
    if not has_command_center then return end

    local noremap = { noremap = true }

    command_center.add({
      {
        description = "Show git status",
        cmd = "<CMD>Git<CR>",
      }, {
        description = "Show gitdiff of current buffer",
        cmd = "<CMD>Git diff<CR>",
      }, {
        description = "Show git blame of current buffer",
        cmd = "<CMD>Git blame<CR>",
        keybindings = { "n", "<leader>gbb", noremap}
      }, {
        description = "Solve git merge conflix in quick fix list",
        cmd = "<CMD>Git mergetool<CR>",
      }, {
        description = "Show git diff in quick fix list",
        cmd = "<CMD>Git difftool<CR>",
      }, {
        description = "Show git diff in split",
        cmd = "<CMD>Gdiffsplit<CR>",
      }, {
        description = "Show git diff in vertical split",
        cmd = "<CMD>Gvdiffsplit<CR>",
      }
    })
  end
}
