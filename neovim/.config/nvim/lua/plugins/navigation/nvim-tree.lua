return {
  "kyazdani42/nvim-tree.lua",

  event = { "VeryLazy" },

  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },

  config = function()
    local nvim_tree = require("nvim-tree")
    local style = require("settings.style")
    local fn = require("settings.fn")

    -- a list of groups can be found at `:help nvim_tree_highlight`
    -- vim.cmd "highlight NvimTreeFolderIcon guibg=blue"
    local custom_mapping = {
      { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
      { key = { "o", "C-e" }, action = "edit_in_place" },
      { key = { "O" }, action = "edit_no_picker" },
      { key = { "<C-c>" }, action = "cd" },
      { key = "<C-v>", action = "vsplit" },
      { key = "<C-s>", action = "split" },
      { key = "<C-t>", action = "tabnew" },
      { key = "<C-k>", action = "prev_sibling" },
      { key = "<C-j>", action = "next_sibling" },
      { key = "P", action = "parent_node" },
      { key = "x", action = "close_node" },
      { key = "<Tab>", action = "preview" },
      { key = "<C-u>", action = "first_sibling" },
      { key = "<C-d>", action = "last_sibling" },
      { key = "H", action = "toggle_ignored" },
      { key = "I", action = "toggle_dotfiles" },
      { key = "R", action = "refresh" },
      { key = "a", action = "create" },
      { key = "d", action = "remove" },
      { key = "D", action = "trash" },
      { key = "r", action = "rename" },
      { key = "<C-r>", action = "full_rename" },
      { key = "<c-x>", action = "cut" },
      { key = "c", action = "copy" },
      { key = "p", action = "paste" },
      { key = "yy", action = "copy_name" },
      { key = "yd", action = "copy_path" },
      { key = "yp", action = "copy_absolute_path" },
      { key = "[c", action = "prev_git_item" },
      { key = "]c", action = "next_git_item" },
      { key = "u", action = "dir_up" },
      { key = "o", action = "system_open" },
      { key = "f", action = "live_filter" },
      { key = "F", action = "clear_live_filter" },
      { key = "q", action = "close" },
      { key = "X", action = "collapse_all" },
      { key = "E", action = "expand_all" },
      { key = "S", action = "search_node" },
      { key = ".", action = "run_file_command" },
      { key = "K", action = "toggle_file_info" },
      { key = "?", action = "toggle_help" },
    }

    -- each of these are documented in `:help nvim-tree.OPTION_NAME`
    nvim_tree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      open_on_setup = true,
      open_on_setup_file = false,
      ignore_buffer_on_setup = false,
      ignore_ft_on_setup = {},
      auto_reload_on_write = false,
      create_in_closed_folder = false,
      open_on_tab = false,
      sort_by = "name",
      hijack_unnamed_buffer_when_opening = false,
      hijack_cursor = false,
      update_cwd = true,
      reload_on_bufenter = false,
      respect_buf_cwd = true,
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = style.icons.diagnostic.hint,
          info = style.icons.diagnostic.info,
          warning = style.icons.diagnostic.warning,
          error = style.icons.diagnostic.error,
        },
      },
      on_attach = "disabled",
      remove_keymaps = true,
      view = {
        hide_root_folder = false,
        width = 30,
        side = "left",
        preserve_window_proportions = true,
        number = false,
        relativenumber = true,
        signcolumn = "yes",
        mappings = {
          list = custom_mapping,
        },
      },
      renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "icon",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = true,
          icons = {
            corner = "└",
            item = "│",
            edge = "│",
            none = "  ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "after",
          padding = " ",
          symlink_arrow = style.icons.symbolic_arrow,
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
          },
          glyphs = {
            default = style.icons.file.default,
            symlink = style.icons.file.symlink,
            git = {
              unstaged = style.icons.git.unstaged,
              staged = style.icons.git.staged,
              unmerged = style.icons.git.unmerged,
              renamed = style.icons.git.renamed,
              untracked = style.icons.git.untracked,
              deleted = style.icons.git.deleted,
              ignored = style.icons.git.ignored,
            },
            folder = {
              arrow_open = style.icons.folder.indicator_open,
              arrow_closed = style.icons.folder.indicator_closed,
              default = style.icons.folder.closed,
              open = style.icons.folder.open,
              empty = style.icons.folder.empty_closed,
              empty_open = style.icons.folder.empty_open,
              symlink = style.icons.folder.symlink_closed,
              symlink_open = style.icons.folder.symlink_open,
            },
          },
        },
        special_files = { "README.md", "Makefile", "MAKEFILE" },
      },
      filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
    })

    fn.keymap.set({
      {
        desc = "Toggle nvim-tree",
        cmd = "<CMD>NvimTreeToggle<CR>",
        keys = { "n", "<leader>tt" },
      },
      {
        desc = "Refresh nvim-tree",
        cmd = "<CMD>NvimTreeRefresh<CR>",
        keys = { "n", "<leader>tr" },
      },
      {
        desc = "Reveal current file in nvim-tree",
        cmd = "<CMD>NvimTreeFindFile<CR>",
        keys = { "n", "<leader>tf" },
      },
    })
  end,
}
