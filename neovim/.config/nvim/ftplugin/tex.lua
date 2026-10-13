vim.keymap.set("n", "<localleader>p", "<CMD>VimtexCompile<CR>", {
	buffer = true,
	desc = "Compile and repreview latex doc",
})
