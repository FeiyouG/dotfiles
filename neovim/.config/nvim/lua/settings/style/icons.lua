local M = {
	exit = " ",
	enter = " ",
	layout = " ",
	symbolic_arrow = " ﰣ ",
}

M.file = {
	default = " ",
	symlink = " ",
	modified = " ",
	readonly = " ",
}

M.folder = {
	open_indictor = "−",
	closed_indicator = "+",
	folders = " ",
	open = " ",
	closed = " ",
	empty_open = " ",
	empty_closed = " ",
	symlink_open = " ",
	symlink_closed = " ",
}

M.git = {
	git = " ",
	unstaged = " ",
	staged = " ",
	unmerged = " ",
	renamed = " ",
	untracked = " ",
	deleted = " ",
	ignored = " ",
	modified = " ",
	added = " ",
	added_line = "+",
	deleted_line = "-",
	modified_line = "~",
}

M.diagnostic = {
	diagnostics = " ",
	-- error = " ",
	-- warning = " ",
	-- hint = " ",
	-- info = " ",
	-- other = "﫠"
	error = " ",
	warning = " ",
	info = " ",
	hint = " ",
	other = " ",
}

M.lsp = {
	Text = " ",
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
	File = " ",
	Reference = " ",
	Folder = " ",
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

M.debug = {
	debug = " ",
  bug = " ",
	breakpoint = " ",
	breakpoint_conditional = " ",
	breakpoint_rejected = " ",
	logpoint = " ",
	stopped = " ",
}

M.test = {
	test = " ",
	fix = " ",
}

M.comment = {
  note = " ",
	hack = " ",
  todo = " ",
  optimized = " ",
  bookmark = " "
}

return M
