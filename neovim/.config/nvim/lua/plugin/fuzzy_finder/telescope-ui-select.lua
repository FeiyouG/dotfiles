return {
  'nvim-telescope/telescope-ui-select.nvim',

  config = function()
    local has_telescope, telescope = pcall(require, "telescope")
    if not has_telescope then return end

    telescope.setup {
      extensions = {
        ["ui-select"] = {
          -- Use get_cursor theme
          require("telescope.themes").get_cursor(),
        }
      }
    }

    telescope.load_extension("ui-select")
  end
}
