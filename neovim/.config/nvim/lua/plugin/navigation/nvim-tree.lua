return {
  'kyazdani42/nvim-tree.lua',

  requires = {
    'kyazdani42/nvim-web-devicons'
  },

  config = function()

    local nvim_tree = require("nvim-tree")

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
    nvim_tree.setup {
      disable_netrw                      = true,
      hijack_netrw                       = true,
      open_on_setup                      = true,
      open_on_setup_file                 = false,
      ignore_buffer_on_setup             = false,
      ignore_ft_on_setup                 = {},
      auto_reload_on_write               = false,
      create_in_closed_folder            = false,
      open_on_tab                        = false,
      sort_by                            = "name",
      hijack_unnamed_buffer_when_opening = false,
      hijack_cursor                      = false,
      update_cwd                         = true,
      reload_on_bufenter                 = false,
      respect_buf_cwd                    = true,
      hijack_directories                 = {
        enable = true,
        auto_open = true,
      },
      update_focused_file                = {
        enable      = true,
        update_cwd  = true,
        ignore_list = {}
      },
      system_open                        = {
        cmd  = nil,
        args = {}
      },
      diagnostics                        = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "???",
          info = "???",
          warning = "???",
          error = "???",
        }

      },
      view                               = {
        hide_root_folder = false,
        width = 30,
        height = 30,
        side = 'left',
        preserve_window_proportions = true,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          custom_only = true,
          list = custom_mapping
        },
      },
      renderer                           = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "icon",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = true,
          icons = {
            corner = "??? ",
            edge = "??? ",
            none = "  ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ??? ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = '???',
            symlink = '???',
            git = {
              unstaged = "???",
              staged = "???",
              unmerged = "???",
              renamed = "???",
              untracked = "???",
              deleted = "???",
              ignored = "???"
            },
            folder = {
              arrow_open = "???",
              arrow_closed = "???",
              default = "???",
              open = "???",
              empty = "???",
              empty_open = "???",
              symlink = "???",
              symlink_open = "???",
            },
          },
        },
        special_files = { 'README.md', 'Makefile', 'MAKEFILE' },
      },
      filters                            = {
        dotfiles = false,
        custom = {},
        exclude = {},
      },
      git                                = {
        enable = true,
        ignore = true,
        timeout = 400,
      },
      actions                            = {
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
          }
        }
      },
      trash                              = {
        cmd = "trash",
        require_confirm = true
      },
    }
  end,

  defer = function()
    -- MARK: Register and add to command_center
    local has_command_center, command_center = pcall(require, "command_center")
    if not has_command_center then return end

    local noremap = { noremap = true }

    command_center.add({
      {
        description = "Toggle nvim-tree",
        cmd = "<CMD>NvimTreeToggle<CR>",
        keybindings = { "n", "<leader>tt", noremap },
      }, {
        description = "Refresh nvim-tree",
        cmd = "<CMD>NvimTreeRefresh<CR>",
        keybindings = { "n", "<leader>tr", noremap },
      }, {
        description = "Reveal current file in nvim-tree",
        cmd = "<CMD>NvimTreeFindFile<CR>",
        keybindings = { "n", "<leader>tf", noremap },
      }
    })

  end
}
