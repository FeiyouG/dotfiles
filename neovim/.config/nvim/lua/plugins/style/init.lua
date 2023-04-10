return {
	require("plugins.style.onenord"),
  require("plugins.style.heirline"),
	require("plugins.style.nvim-ufo"),
	require("plugins.style.dressing"),
	require("plugins.style.neoscroll"),
	require("plugins.style.colorizer"),
	require("plugins.style.todo-comments"),
	{ "fladson/vim-kitty", ft = { "conf" } }, -- Syntax highlight for kitty config files
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "godlygeek/tabular" },
}
