---- MARK: Declaring local variables -----
local o = vim.opt
-- local wo = vim.wo
-- local fn = vim.fn

---- MARK: MISC ----
--disable compatibility to old-time vi
vim.cmd "set nocompatible"
-- hide unused buffers
o.hidden = true
-- set an 80 column boarder for good coding style
vim.cmd "set cc=80"
-- speed up scrolling in Vim
o.ttyfast = true
-- enables clipboard between vim/neovim and other applicationos
o.clipboard = "unnamedplus"
-- disable spelling check
vim.cmd "set nospell"

-- for italics in tmux
vim.cmd "set t_ZH=^[[3m"
vim.cmd "set t_ZR=^[[23mt=menu,menuone,noselect"

-- For Pane Management
o.splitbelow = true
o.splitright = true

-- For conceal suppor t
o.conceallevel = 2

---- MARK: SEARCH AND REPLACE----
-- case insensitive matching
o.ignorecase = true
-- highlight search results
o.hlsearch = true
-- show replacements in a split screen, before applying to the file
vim.cmd "set inccommand=split"


---- MARK: TAB AND INDENTATION ----
-- number of columns occupied by a tab character
o.tabstop=2
-- width for autoidnents
o.shiftwidth=2
-- how far cursor travels by pressing tab
o.softtabstop=2
-- converts tab to whitespace
o.expandtab = true
-- indent a new line the same amound as the line before it
o.autoindent = true


---- MARK: MOUSE AND CURSOR ----
-- enable mouse click
o.mouse = "a"
-- highlight current cursorline
o.cursorline = true
-- highlight current cursorcolumn
-- set cursorcolumn

-- -- line number --
-- Default hybrid line number
o.relativenumber = true          -- show line numbers starting from the current one
o.number = true 		            -- add line num
