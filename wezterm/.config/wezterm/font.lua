local wezterm = require("wezterm")

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
	-- "Symbols Nerd Font Mono" (brew cask font-symbols-only-nerd-font) supplies Nerd Fonts v3 icons
	local names = { name, "Symbols Nerd Font Mono", "Noto Color Emoji", "JetBrains Mono" }
	return wezterm.font_with_fallback(names, params)
end

return {
	font = font_with_fallback("Victor Mono"),
	font_rules = {
		-- Italic Font
		{
			italic = true,
			font = font_with_fallback("Victor Mono", { style = "Oblique" }),
		},

		-- Bold Font
		{
			intensity = "Bold",
			font = font_with_fallback("Victor Mono", { weight = "Bold" }),
		},

		-- Bold Italic Font
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback("Victor Mono Bold Oblique", { weight = "Bold", style = "Oblique" }),
		},

		-- SemiBold Font
		{
			intensity = "Half",
			font = font_with_fallback("Victor Mono", { weight = "Medium" }),
		},

		-- SemiBold Italic Font
		{
			italic = true,
			intensity = "Half",
			font = font_with_fallback("Victor Mono", { weight = "Medium", style = "Oblique" }),
		},
	},

	font_size = 13.5,

	-- Disable ligature
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
}
