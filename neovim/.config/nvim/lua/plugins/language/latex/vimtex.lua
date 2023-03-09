return {
	"lervag/vimtex",
	ft = { "latex", "tex" },
	config = function()
		vim.g.vimtex_compiler_latexmk = {
			build_dir = "out",
		}

		require("settings.fn").keymap.set({
			{
				desc = "Compile and repreview latex doc",
				keys = { "n", "<localleader>p" },
				cmd = " <CMD>VimtexCompile<CR>",
			},
		})
	end,
}
