local M = {
	exit = " ",
	enter = " ",
	layout = " ",
	symbolic_arrow = " 壟 ",
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
	open = " ",
	closed = " ",
	empty_open = " ",
	empty_closed = " ",
	symlink_open = " ",
	symlink_closed = " ",
}

M.git = {
	git = " ",
  branch = "",
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

M.debug = {
	debug = " ",
	bug = " ",
	breakpoint = " ",
	breakpoint_conditional = "ﯷ ",
	breakpoint_rejected = " ",
	logpoint = " ",
	stopped = " ",
}

M.test = {
	test = " ",
	fix = " ",
}

M.cmp = {
	Icon = " ",
	Tmux = " ",
	Git = M.git.git,
	Dap = M.debug.debug,
	Treesitter = " ",
	Result = " ",
	Word = " ",
}

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
	File = M.file.default,
	Reference = " ",
	Folder = M.folder.closed,
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

M.comment = {
	note = " ",
	hack = " ",
	todo = " ",
	optimized = " ",
	bookmark = " ",
}

M.system = {
  servers = "歷"
}

return M
