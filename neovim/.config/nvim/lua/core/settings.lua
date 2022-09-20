---- MARK: MISC
vim.cmd "set nocompatible"                        --  Disable compatibility to old-time vi
vim.cmd "set completeopt=menu,menuone,noselect"
vim.opt.hidden = true                             --  Hide unused buffers
vim.cmd "set cc=80"                               --  Set an 80 column boarder for good coding style
vim.opt.ttyfast = true                            --  Speed up scrolling in neovim
vim.opt.clipboard = "unnamedplus"                 --  Use same clipboard between neovim and system
vim.cmd "set nospell"                             --  Disable spelling checking
vim.wo.scrolloff = 0                              --  minimal # of lines to keep above/below the cursor


---- MARK: ENABLE TMUX ITALIC FONT
vim.cmd "set t_ZH=^[[3m"
vim.cmd "set t_ZR=^[[23mt=menu,menuone,noselect"


---- MARK: PANE MANAGEMENT
vim.opt.splitbelow = true                         --  Always add new pane below
vim.opt.splitright = true                         --  Always add new pane on right
vim.o.winwidth = 10                               --  Minimal number of columns for the current window.
vim.o.winminwidth = 10                            --  The minimal width of a window, when it's not the current window.
vim.o.equalalways = false


---- MARK: SEARCH AND REPLACE
vim.opt.ignorecase = true                         --  Case insensitive matching
vim.opt.hlsearch = true                           --  Highlight search results
vim.cmd "set inccommand=split"                    --  Show replace result in a split screen before applying


---- MARK: TAB AND INDENTATION
vim.opt.tabstop = 2                               --  Bumber of columns occupied by a tab character
vim.opt.shiftwidth = 2                            --  Width for autoidnents
vim.opt.softtabstop = 2                           --  How far cursor travels by pressing tab
vim.opt.expandtab = true                          --  Converts tab to whitespace
vim.opt.autoindent = true                         --  Indent a new line the same amound as the line before it


---- MARK: MOUSE AND CURSOR
vim.opt.mouse = "a"                               --  Enable mouse click
vim.opt.cursorline = true                         --  Highlight current cursorline
-- set cursorcolumn                               --  Highlight current cursorcolumn


---- MARK: LINE NUMBER
vim.opt.relativenumber = true                     --  Show relative line number (hybrid)
vim.opt.number = true                             --  Show absolute line number (hybtif)


---- MAARK: FILETYPE SETTING
vim.g.do_filetype_lua = 1                         --  Use filetype.lua for faster filetype dection
-- vim.g.did_load_filetypes = 0                   --  disable filetype.vim (Don't do it now since filtype.la is not yet comprehesive)

---- MARK: TERM SETTINGS
vim.o.termguicolors = true                        --  Enable true colors if avaliable
vim.cmd "let &t_ut=''"

---- MAKR: FOLDING ----
vim.o.foldlevel = 99                              --  So most foldings are unfold

---- MARK: Global status line ----
-- Set in plugin/style/lualine.lua
-- vim.cmd "hi link WinSeparator FloatBorder"
