local nvim_tree = require("nvim-tree")

local command_center = require("command_center")
local noremap = {noremap = true}

command_center.add({
  {
    description = "Toggle nvim-tree",
    command = "NvimTreeToggle",
    keybindings = { "n", "<leader>tt", noremap },
  }, {
    description = "Refresh nvim-tree",
    command = "NvimTreeRefresh",
    keybindings = { "n", "<leader>tr", noremap },
  }, {
    description = "Reveal current file in nvim-tree",
    command = "NvimTreeFindFile",
    keybindings = { "n", "<leader>tf", noremap },
  }
})


vim.cmd "let g:nvim_tree_git_hl = 1"
vim.cmd "let g:nvim_tree_highlight_opened_files = 1"
vim.cmd "let g:nvim_tree_add_trailing = 1"
vim.cmd "let g:nvim_tree_respect_buf_cwd = 1"

-- List of filenames that gets highlighted with NvimTreeSpecialFile
-- let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }

vim.cmd([[let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "−",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }
]])

-- NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

-- a list of groups can be found at `:help nvim_tree_highlight`
-- vim.cmd "highlight NvimTreeFolderIcon guibg=blue"

local custom_mapping = {
  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
  { key = {"O"},                          action = "edit_no_picker" },
  { key = {"<C-c>"},                      action = "cd" },
  { key = "v",                            action = "vsplit" },
  { key = "s",                            action = "split" },
  { key = "t",                            action = "tabnew" },
  { key = "<C-k>",                        action = "prev_sibling" },
  { key = "<c-j>",                        action = "next_sibling" },
  { key = "P",                            action = "parent_node" },
  { key = "x",                            action = "close_node" },
  { key = "<Tab>",                        action = "preview" },
  { key = "K",                            action = "first_sibling" },
  { key = "J",                            action = "last_sibling" },
  { key = "H",                            action = "toggle_ignored" },
  { key = "I",                            action = "toggle_dotfiles" },
  { key = "R",                            action = "refresh" },
  { key = "a",                            action = "create" },
  { key = "d",                            action = "remove" },
  { key = "D",                            action = "trash" },
  { key = "r",                            action = "rename" },
  { key = "<C-r>",                        action = "full_rename" },
  { key = "<c-x>",                        action = "cut" },
  { key = "c",                            action = "copy" },
  { key = "p",                            action = "paste" },
  { key = "yy",                           action = "copy_name" },
  { key = "yd",                           action = "copy_path" },
  { key = "yf",                           action = "copy_absolute_path" },
  { key = "[c",                           action = "prev_git_item" },
  { key = "]c",                           action = "next_git_item" },
  { key = "u",                            action = "dir_up" },
  { key = "o",                            action = "system_open" },
  { key = "q",                            action = "close" },
  { key = "?",                            action = "toggle_help" },
}
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = true,
  ignore_ft_on_setup  = {},
  -- auto_close          = true,
  open_on_tab         = true,
  hijack_cursor       = false,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    -- icons = {
      -- hint = "",
      -- info = "",
      -- warning = "",
      -- error = "",
    --}
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }

  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = true,
    mappings = {
      custom_only = true,
      list = custom_mapping
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
  actions = {
    change_dir = {
      global = false,
    },
    open_file = {
      quit_on_open = false,
    }
  }
}
