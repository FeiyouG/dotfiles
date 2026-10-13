-- Set conceal level to 3 for markdown
vim.opt.conceallevel = 3

vim.keymap.set("n", "<localleader>p", "<CMD>MarkdownPreviewToggle<CR>", {
	buffer = true,
	desc = "Toggle markdown preview",
})
