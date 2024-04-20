return {
  {
    "stevearc/oil.nvim",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    keys = {
      { "<leader>ex", "<CMD>Oil<CR>", mode = "n", desc = "Open parent directory in Oil" }
    },

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
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-r>"] = "actions.refresh",
          ["u"] = "actions.parent",
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

      vim.list_extend(settings.ft.exclude_winbar.filetype, { "oil" })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",

    event = { "VeryLazy" },

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    keys = {
      { "<leader>et", "<CMD>NvimTreeToggle<CR>",     mode = "n", desc = "Toggle NvimTree" },
      { "<leader>ef", "<CMD>NvimTreeFindFile<CR>", mode = "n", desc = "Reveal current file in NvimTree" },
    },

    config = function()
      local nvim_tree = require("nvim-tree")
      local fn = require("settings.fn")

      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "o", api.node.open.replace_tree_buffer, opts("Open: In Place"))
        vim.keymap.set("n", "C-e", api.node.open.replace_tree_buffer, opts("Open: In Place"))
        vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
        vim.keymap.set("n", "<C-c>", api.tree.change_root_to_node, opts("CD"))
        vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
        vim.keymap.set("n", "<C-k>", api.node.navigate.sibling.prev, opts("Previous Sibling"))
        vim.keymap.set("n", "<C-j>", api.node.navigate.sibling.next, opts("Next Sibling"))
        vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
        vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
        vim.keymap.set("n", "<C-u>", api.node.navigate.sibling.first, opts("First Sibling"))
        vim.keymap.set("n", "<C-d>", api.node.navigate.sibling.last, opts("Last Sibling"))
        vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
        vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
        vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
        vim.keymap.set("n", "a", api.fs.create, opts("Create"))
        vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
        vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
        vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
        vim.keymap.set("n", "<c-x>", api.fs.cut, opts("Cut"))
        vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
        vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
        vim.keymap.set("n", "yy", api.fs.copy.filename, opts("Copy Name"))
        vim.keymap.set("n", "yd", api.fs.copy.relative_path, opts("Copy Relative Path"))
        vim.keymap.set("n", "yp", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
        vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
        vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
        vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "o", api.node.run.system, opts("Run System"))
        vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
        vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
        vim.keymap.set("n", "q", api.tree.close, opts("Close"))
        vim.keymap.set("n", "zM", api.tree.collapse_all, opts("Collapse"))
        vim.keymap.set("n", "zR", api.tree.expand_all, opts("Expand All"))
        vim.keymap.set("n", "/", api.tree.search_node, opts("Search"))
        vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
        vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
        vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
      end

      -- each of these are documented in `:help nvim-tree.OPTION_NAME`
      nvim_tree.setup({
        auto_reload_on_write = false,
        disable_netrw = true,
        hijack_netrw = true,
        on_attach = on_attach,
        create_in_closed_folder = false,
        hijack_unnamed_buffer_when_opening = false,
        hijack_cursor = false,
        update_cwd = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        select_prompts = true,
        view = {
          preserve_window_proportions = true,
          number = false,
          relativenumber = true,
          float = {
            enable = false,
            open_win_config = {
              relative = "cursor",
              border = settings.icons.editor.border.rounded,
            },

          }
        },
        renderer = {
          add_trailing = true,
          group_empty = true,
          highlight_git = true,
          highlight_opened_files = "icon",
          indent_markers = {
            enable = true,
            icons = {
              corner = settings.icons.editor.border.rounded[7],
              edge = settings.icons.editor.border.rounded[8],
              item = settings.icons.editor.border.rounded[8],
              bottom = settings.icons.editor.border.rounded[2],
            },
          },
          icons = {
            git_placement = "after",
            symlink_arrow = settings.icons.fs.symbolic_arrow,
            show = {
              folder_arrow = false,
            },
            glyphs = {
              default = settings.icons.fs.file.default,
              symlink = settings.icons.fs.file.symlink,
              bookmark = settings.icons.fs.file.indicator.bookmark,
              modified = settings.icons.fs.file.indicator.modified,
              folder = {
                arrow_closed = settings.icons.fs.folder.indicator.closed,
                arrow_open = settings.icons.fs.folder.indicator.open,
                default = settings.icons.fs.folder.closed,
                open = settings.icons.fs.folder.open,
                empty = settings.icons.fs.folder.empty_closed,
                empty_open = settings.icons.fs.folder.empty_open,
                symlink = settings.icons.fs.folder.symlink_open,
                symlink_open = settings.icons.fs.folder.symlink_open,
              },
              git = {
                unstaged = settings.icons.vc.unstaged,
                staged = settings.icons.vc.staged,
                unmerged = settings.icons.vc.unmerged,
                renamed = settings.icons.vc.renamed,
                untracked = settings.icons.vc.untracked,
                deleted = settings.icons.vc.deleted,
                ignored = settings.icons.vc.ignored,
              },
            },
          },
          special_files = { "README.md", "Makefile", "MAKEFILE" },
        },
        update_focused_file = {
          enable = true,
          update_root = true,
          ignore_list = {},
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = settings.icons.diagnostic.hint_filled,
            info = settings.icons.diagnostic.info_filled,
            warning = settings.icons.diagnostic.warning_filled,
            error = settings.icons.diagnostic.error_filled,
          },
        },
        actions = {
          use_system_clipboard = true,
          file_popup = {
            open_win_config = {
              relative = "cursor",
              border = settings.icons.editor.border.rounded,
            },
          },
          open_file = {
            resize_window = false,
            window_picker = {
              enable = true,
            },
          },
          remove_file = {
            close_window = false,
          },
        },
        trash = {
          cmd = "trash",
        },
      })

      -- SECTION: Open on startup
      local function open_nvim_tree(data)
        local open = false
        open = open or (data.file == "" and vim.bo[data.buf].buftype == "") -- buffer is a [No Name]
        open = open or vim.fn.isdirectory(data.file) == 1                   -- buffer is a directory

        if open then
          require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
        end
      end

      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  }
}
