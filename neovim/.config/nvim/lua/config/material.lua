require('material').setup{
	contrast = {
		sidebars = true, -- enable contrast for sidebar-like windows ( for example nvim-tree )
		floating_windows = true, -- enable contrast for floating windows
		line_numbers = false, -- enable contrast background for line numbers
		sign_column = false, -- enable contrast background for the sign column
    cursor_line = false, -- enable darker background for the cursor line
		non_current_windows = true, -- enable darker background for non-current windows
		popup_menu = true, -- enable lighter background for the popup menu
	},

  italics = {
		comments = true, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false-- Enable italic variables
	},

  contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
		"qf", -- Darker qf list background
    "nvim-tree",
    "calendar",
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false-- Enable higher contrast text for darker style
	},

	disable = {
		borders = false, -- Disable borders between verticaly split windows
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = true-- Hide the end-of-buffer lines
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

  -- custom_highlights = {
		-- CursorLine = { bg = '#00000', gui = 'underline' },
	-- }

}

vim.g.material_style = "darker"

vim.cmd "colorscheme material"
