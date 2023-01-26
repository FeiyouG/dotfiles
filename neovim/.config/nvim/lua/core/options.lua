-- SECTION: Editor
vim.opt.compatible = false --  Disable compatibility to old-time vi (default)
vim.opt.clipboard = "unnamedplus" --  Use same clipboard between neovim and system
vim.opt.completeopt = { "menuone", "noselect" }

vim.opt.mouse = "a" --  Enable mouse click
vim.opt.cursorline = true --  Highlight current cursorline

vim.opt.ttyfast = true --  Speed up scrolling in neovim
vim.o.updatetime = 250
vim.opt.hidden = true --  Hide unused buffers

vim.cmd("syntax enable") --  Enable syntax (default)

-- SECTION: Style and View
vim.opt.laststatus = 3 --  use global status line
vim.opt.showtabline = 0 --  hide tabline

vim.opt.relativenumber = true --  Show relative line number (hybrid)
vim.opt.number = true --  Show absolute line number (hybrid)

vim.opt.history = 100 --  reduce noise for command history search
vim.opt.cmdheight = 1 --  set command line height to 1 (default)
vim.opt.showmode = true --  show the current mode in command line (default)

vim.opt.pumheight = 0 --  max number of items in popup menu (default)
vim.opt.pumwidth = 10 --  min width popup menu
vim.opt.winblend = 0 --  % transparency (default)

vim.wo.scrolloff = 3 --  minimal # of lines to keep above/below the cursor
vim.wo.sidescrolloff = 0 --  minimal # of lines to keep on left/right of the window (when set to nowrap)

vim.opt.wrap = false --  nowrap
vim.opt.linebreak = true --  do not break up full words on wrap
-- vim.opt.textwidth = 80
-- vim.opt.colorcolumn = "+1" --  relative to textwidth
vim.opt.colorcolumn = "80" --  relative to textwidth
vim.opt.signcolumn = "yes:1" --  for lsp diagnostics

vim.opt.conceallevel = 0 --  disable conceal

vim.o.foldlevel = 99 --  open all folds by default

-- SECTION: Undo
vim.opt.undofile = true --  enable persistent undo history
vim.opt.undolevels = 500 --  less undos saved for quicker loading of undo history

-- SECTION: Search
vim.opt.ignorecase = true --  Case insensitive matching
vim.opt.smartcase = true --  Override 'ignorecase' iff the search contains upper case character
vim.opt.hlsearch = true --  Highlight search results (default)
vim.opt.inccommand = "split" --  Show replace result in a split screen before applying
if vim.fn.executable("rg") then
	vim.opt.grepprg = "rg --vimgrep" --  use rg for :grep
end

--------------------------------------------------------------------------------
-- SECTION: Spell
vim.opt.spell = true --  enable spelling checking
vim.opt.spelllang = { "en", "cjk" }
vim.opt.spelloptions = { "camel", "noplainbuffer" }
vim.opt.spellfile = require("settings.lang").spell.spellfile
-- TODO: Add more languages & add spell file

-- SECTION: Tab, Whitespace, and Indentation
vim.opt.tabstop = 2 --  Bumber of columns occupied by a tab character
vim.opt.shiftwidth = 2 --  Width for autoidnents
vim.opt.shiftround = true --  Round indent to multiple of 'shiftwidth'
vim.opt.softtabstop = 2 --  How far cursor travels by pressing tab
vim.opt.expandtab = true --  Converts tab to whitespace
-- NOTE: abc

vim.opt.autoindent = true --  Indent a new line the same amound as the line before it
vim.opt.breakindent = true -- wrapped line will have the same indent

-- SECTION: Invisible characters
vim.opt.list = false
vim.opt.listchars = {
	tab = "  ",
	multispace = "·", --  multiple consecutive spaces
	lead = "·", --  leading spaces
	nbsp = "ﮊ", --  non-breakable space character
	leadmultispace = "·",
	--  precedes = "…",
	--  extends = "…",
}
vim.opt.fillchars = {
	eob = " ", --  no ~ for the eof
	fold = " ", --  no dots for folds
}
vim.opt.showbreak = "↪ " --  precedes wrapped lines

-- SECTION: Window and Split
vim.opt.splitbelow = true --  Always add new pane below
vim.opt.splitright = true --  Always add new pane on right
vim.opt.winwidth = 10 --  Minimal number of columns for the current window.
vim.opt.winminwidth = 10 --  The minimal width of a window, when it's not the current window.
vim.o.equalalways = true --  Width of windows are automatically equalized (default)

-- SECTION: For external apps
vim.opt.title = true --  show titlestring as title
vim.opt.titlelen = 0 --  do not shorten title
vim.opt.titlestring = '%{expand("%:p")}'

vim.o.termguicolors = true --  Enable true colors if avaliable
vim.cmd("let &t_ut=''")
