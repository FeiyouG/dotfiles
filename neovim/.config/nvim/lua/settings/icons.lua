local M = {}
_G.settings.icons = M

-- MARK: editor
M.editor = {
	statuscolumn = {
		-- fold_open = " ▏̵",
		-- fold_close = "⊖̩̍",
		gitsigns = " ▏",
    folds_open = "",
    folds_closed = "",
	},
	border = {
		rounded = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		rounded_with_hl = {
			{ "╭", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╮", "FloatBorder" },
			{ "│", "FloatBorder" },
			{ "╯", "FloatBorder" },
			{ "─", "FloatBorder" },
			{ "╰", "FloatBorder" },
			{ "│", "FloatBorder" },
		},
		winblend = 0,
		winhighlight = "FloatBorder:FloatBorder,CursorLine:TelescopeSelection,Search:None",
	},
  select = "祈"
}

-- MARK: Filesystem
M.fs = {
	symbolic_arrow = " 壟 ",
	file = {
		default = " ",
		symlink = " ",
		indicator = {
			modified = " ",
			readonly = " ",
      bookmark = " "
		},
	},
	folder = {
		folders = " ",
		open = " ",
		closed = " ",
		empty_open = " ",
		empty_closed = " ",
		symlink_open = " ",
		symlink_closed = " ",
		indicator = {
			open = "−",
			closed = "+",
		},
	},
}

-- MARK: Version Control
M.vc = {
	git = " ",
	branch = "",
	untracked = " ",
	unstaged = " ",
	staged = " ",
	unmerged = " ",
	renamed = " ",
	removed = " ",
	ignored = " ",
	changed = " ",
	added = " ",
	indicator = {
		added = "+",
		removed = "-",
		changed = "~",
	},
}

-- MARK: Diagnostics
M.diagnostic = {
	diagnostics = " ",
	error = " ",
	warning = " ",
	hint = " ",
	info = " ",
	other = "﫠",
	error_filled = " ",
	warning_filled = " ",
	info_filled = " ",
	hint_filled = " ",
	other_filled = " ",
}

-- MARK: Debug and Testing
M.debug = {
	debug = " ",
	bug = " ",
	breakpoint = " ",
	breakpoint_conditional = "ﯷ ",
	breakpoint_rejected = " ",
	logpoint = " ",
	stopped = " ",
	pause = "",
	play = "",
	step_into = " ",
	step_over = " ",
	step_out = " ",
	step_back = " ",
	run_last = "↻ ",
	terminate = " ",
}

M.test = {
	test = " ",
	fix = " ",
}

-- MARK: Completion source
M.cmp = {
	Icon = " ",
	Tmux = " ",
	Git = M.vc.git,
	Dap = M.debug.debug,
	Treesitter = " ",
	Result = " ",
	Word = " ",
}

-- MARK: Language Server Protocol
M.lsp = {
	Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = " ",
	Variable = " ",
	Class = " ",
	Interface = " ",
	Module = " ",
	Property = " ",
	Unit = "塞",
	Value = " ",
	Enum = " ",
	Keyword = " ",
	Snippet = " ",
	Color = " ",
	File = M.fs.file.default,
	Reference = " ",
	Folder = M.fs.folder.closed,
	EnumMember = " ",
	Constant = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
	Namespace = " ",
	Package = " ",
	String = " ",
	Number = " ",
	Boolean = " ",
	Array = " ",
	Object = " ",
	Key = " ",
	Null = " ",
}

-- MARK: TODO Comment
M.comment = {
	note = " ",
	hack = " ",
	todo = " ",
	optimized = " ",
	bookmark = " ",
}

return M
