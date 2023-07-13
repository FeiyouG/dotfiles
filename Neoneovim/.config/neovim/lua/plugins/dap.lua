-- FIX: Not working yet (at least for python and java)
return {
	{
		"mfussenegger/nvim-dap",
		-- event = { "SUBMODE_DEBUG" },
		config = function(_, debuggers)
			local dap = require("dap")

			for debugger, config in pairs(debuggers) do
				dap.adapters[debugger] = config.adapters
				dap.configurations[debugger] = config.configurations
			end

			-- Customize nvim-dap
			vim.fn.sign_define("DapBreakpoint", {
				text = settings.icons.debug.breakpoint,
				linehl = "DapBreakpointLine",
			})

			vim.fn.sign_define("DapBreakpointCondition", {
				text = settings.icons.debug.breakpoint_conditional,
				linehl = "DapBreakpointConditionLine",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = settings.icons.debug.breakpoint_rejected,
				linehl = "DapBreakpointRejectedLine",
			})

			vim.fn.sign_define("DapLogPoint", {
				text = settings.icons.debug.logpoint,
				linehl = "DapLogPointLine",
			})

			vim.fn.sign_define("DapStopped", {
				text = settings.icons.debug.stopped,
				linehl = "DadStoppedLine",
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",

		dependencies = {
			"mfussenegger/nvim-dap",
		},

		config = function()
			local dapui = require("dapui")

			dapui.setup({
				icons = {
					expanded = settings.icons.fs.folder.indicator.open,
					collapsed = settings.icons.fs.folder.indicator.closed,
				},
				layouts = {
					{
						elements = {
							"watches",
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 10,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					element = "repl",
					icons = settings.icons.debug,
				},
				floating = {
					border = settings.icons.editor.border.rounded_with_hl,
				},
			})

			-- Automatically open and close dapui, if installed
			local debug_win = nil
			local debug_tab = nil
			local debug_tabnr = nil

			local function open_in_tab()
				if debug_win and vim.api.nvim_win_is_valid(debug_win) then
					vim.api.nvim_set_current_win(debug_win)
					return
				end

				vim.cmd("tabedit %")
				debug_win = vim.fn.win_getid()
				debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
				debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

				dapui.open()
			end

			local function close_tab()
				dapui.close()

				if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
					vim.api.nvim_exec("tabclose " .. debug_tabnr, false)
				end

				debug_win = nil
				debug_tab = nil
				debug_tabnr = nil
			end

			local dap = require("dap")
			if dap then
				dap.listeners.after.event_initialized["dapui_config"] = function()
					open_in_tab()
				end

				dap.listeners.before.event_terminated["dapui_config"] = function()
					close_tab()
				end

				dap.listeners.before.event_exited["dapui_config"] = function()
					close_tab()
				end
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",

		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},
}
