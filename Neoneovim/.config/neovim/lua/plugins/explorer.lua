return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = {
          "permissions",
          "size",
          "mtime",
          "icon",
        },
        -- Window-local options to use for oil buffers
        win_options = {
          cursorcolumn = false,
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["u"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["g."] = "actions.toggle_hidden",
        },
        view_options = {
          show_hidden = true,
        },
        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 2,
          border = settings.icons.editor.border.rounded,
        },
        preview = {
          border = settings.icons.editor.border.rounded,
        },
        progress = {
          border = settings.icons.editor.border.rounded,
        },
      })

      vim.keymap.set("n", "<leader>fx", require("oil").open, { desc = "Open parent directory" })

      vim.list_extend(settings.ft.exclude_winbar.filetype, {
        "oil",
      })
    end,
  },
}
