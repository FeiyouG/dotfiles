vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Shortcut for save
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")

-- Remove block jump from jump list
vim.keymap.set("n", "}", '<CMD>execute "keepjumps norm! " . v:count1 . "}"<CR>')
vim.keymap.set("n", "{", '<CMD>execute "keepjumps norm! " . v:count1 . "{"<CR>')

-- Delete buffer
vim.keymap.set("n", "<c-w>d", "<CMD>bdelete<CR>")

-- Move between windows
-- vim.keymap.set("n", "<leader><C-h>", "<C-W>H")
-- vim.keymap.set("n", "<leader><C-j>", "<C-W>J")
-- vim.keymap.set("n", "<leader><C-k>", "<C-W>K")
-- vim.keymap.set("n", "<leader><C-l>", "<C-W>L")
-- vim.keymap.set("n", "<c-w><c-c>", "<c-w>c")

-- Resize windows

-- TODO: Use commander instead of vim to set keymaps
-- local commands = require("settings.fn").require("commander")
-- if commander then
--   vim.keymap.set = command.keymap_set
-- end
