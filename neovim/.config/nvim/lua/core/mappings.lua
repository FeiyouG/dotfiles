---- MARK: LOCAL VARIABLES
local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }
-- local silent_noremap_expr = {noremap = true, expr = true, silent = true}


---- MARK: BASIC MAPPINGS ----
-- map the leader key
map("n", "<Space>", "<NOP>", silent_noremap)
vim.g.mapleader = " "

-- move line or visually selected block - alt+j/k
map("n", "<M-Up>", "<cmd>m .-2<CR>==", noremap)
map("n", "<M-Down>", "<cmd>m .+1<CR>==", noremap)
map("i", "<M-Up>", "<cmd>m .-2==<CR>", noremap)
map("i", "<M-Down>", "<cmd>m .+1==<CR>", noremap)
map("v", "<M-Up>", ":m '<-2<CR>gv=gv", noremap)
map("v", "<M-Down>", ":m '>+1<CR>gv=gv", noremap)

-- filepath and pwd to clipboar by yf and yd respectivley
-- map("n", "yf", "<cmd>let @+=expand('%:p')<CR>", silent_noremap)
-- map("n", "yd", "<cmd>let @+=expand('%:p:h')<CR>", silent_noremap)

-- MISC
-- map("n", "<leader>r", "<cmd>source $MYVIMRC<CR>", noremap) -- Shortcut for refresh nvim without restarting
map("n", "<leader>w", "<cmd>w<CR>", noremap) -- Shortcut for save
-- map("n", "<leader>p", "\"_DP", noremap) -- Paste without yank delted text

-- Remove block jump from jump list
map("n", "}", '<CMD>execute "keepjumps norm! " . v:count1 . "}"<CR>', noremap)
map("n", "{", '<CMD>execute "keepjumps norm! " . v:count1 . "{"<CR>', noremap)


---- MARK: Buffer Management ----
map("n", "<c-w>d", "<CMD>bdelete<CR>", noremap)

---- MAKR: PANE & TAB MANAGEMENT ----
-- Move split panes to left/bottom/top/right
-- map("n", "<leader><C-h>", "<C-W>H", noremap)
-- map("n", "<leader><C-j>", "<C-W>J", noremap)
-- map("n", "<leader><C-k>", "<C-W>K", noremap)
-- map("n", "<leader><C-l>", "<C-W>L", noremap)
-- map("n", "<c-w><c-c>", "<c-w>c", noremap)

-- Go to tab
-- map("n", "<leader>1", "1gt", noremap)
-- map("n", "<leader>2", "2gt", noremap)
-- map("n", "<leader>3", "3gt", noremap)
-- map("n", "<leader>4", "4gt", noremap)
-- map("n", "<leader>5", "5gt", noremap)
-- map("n", "<leader>6", "6gt", noremap)
-- map("n", "<leader>7", "7gt", noremap)
-- map("n", "<leader>8", "8gt", noremap)
-- map("n", "<leader>9", "9gt", noremap)
-- map("n", "<leader>0", "<cmd>tablast<CR>", noremap)

-- Go to next and previous tab
-- map("n", "<leader><Right>", "<ctd>tabprevious<cr>", noremap)
-- map("n", "<leader><Left>", "<cmd>tabnext<cr>", noremap)

-- Go to last active tab
-- vim.cmd "au TabLeave * let g:lasttab = tabpagenr()"
-- map("n", "<leader>tt", "<cmd>exe \"tabn \".g:lasttab<cr>", noremap)
