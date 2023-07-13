require("settings")

local function bootstrap(install_path, repo, branch)
	if vim.loop.fs_stat(install_path) then
		return
	end

	local plugin_name = vim.fn.fnamemodify(install_path, ":p:h:y")
	vim.notify("Boostrap " .. plugin_name .. "...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		repo,
		branch and "--branch=" .. branch or "",
		-- "--depth",
		-- "1",
		-- repo,
		install_path,
	})
end

local manager = settings.path.plugin.manager
bootstrap(manager.install_path, manager.url, "stable")
vim.opt.rtp:prepend(manager.install_path)

require("lazy").setup("plugins", {
	root = settings.path.plugin.home,
	dev = {
		path = settings.path.plugin.dev,
	},
	install = {
		missing = true,
		colorscheme = { "onenord" },
	},
	ui = {
		border = settings.icons.editor.border.rounded_with_hl,
	},
})
