local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

local colors = require("settings.style").colors

local fileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
-- We can now define some children separately and add them later

local fileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local fileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "green" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
    },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force=true }
        end
    end,
}

-- let's add the children to our FileNameBlock component
fileNameBlock = utils.insert(fileNameBlock,
    fileIcon,
    utils.insert(FileNameModifer, fileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)

local navic = {
	condition = function()
		return require("nvim-navic").is_available()
	end,
	static = {
		-- create a type highlight map
		type_hl = {
			File = "Directory",
			Module = "@include",
			Namespace = "@namespace",
			Package = "@include",
			Class = "@structure",
			Method = "@method",
			Property = "@property",
			Field = "@field",
			Constructor = "@constructor",
			Enum = "@field",
			Interface = "@type",
			Function = "@function",
			Variable = "@variable",
			Constant = "@constant",
			String = "@string",
			Number = "@number",
			Boolean = "@boolean",
			Array = "@field",
			Object = "@type",
			Key = "@keyword",
			Null = "@comment",
			EnumMember = "@field",
			Struct = "@structure",
			Event = "@keyword",
			Operator = "@operator",
			TypeParameter = "@type",
		},
		-- bit operation dark magic, see below...
		enc = function(line, col, winnr)
			return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
		end,
		-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
		dec = function(c)
			local line = bit.rshift(c, 16)
			local col = bit.band(bit.rshift(c, 6), 1023)
			local winnr = bit.band(c, 63)
			return line, col, winnr
		end,
	},
	init = function(self)
		local data = require("nvim-navic").get_data() or {}
		local children = {}
		-- create a child for each level
		for i, d in ipairs(data) do
			-- encode line and column numbers into a single integer
			local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
			local child = {
				{
					provider = d.icon,
					hl = self.type_hl[d.type],
				},
				{
					-- escape `%`s (elixir) and buggy default separators
					provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
					-- highlight icon only or location name as well
					-- hl = self.type_hl[d.type],

					on_click = {
						-- pass the encoded position through minwid
						minwid = pos,
						callback = function(_, minwid)
							-- decode
							local line, col, winnr = self.dec(minwid)
							vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
						end,
						name = "heirline_navic",
					},
				},
			}
			-- add a separator only if needed
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = " > ",
					hl = { fg = colors.fg },
				})
			end
			table.insert(children, child)
		end
		-- instantiate the new child, overwriting the previous one
		self.child = self:new(children, 1)
	end,
	-- evaluate the children containing navic components
	provider = function(self)
		return self.child:eval()
	end,
	hl = { fg = colors.gray },
	update = "CursorMoved",
}

return {
	navic,
}
