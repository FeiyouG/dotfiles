return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		local debuggers = require("plugins.dap.debuggers")
		local style = require("settings.style")

		for debugger, config in pairs(debuggers) do
			dap.adapters[debugger] = config.adapters
			dap.configurations[debugger] = config.configurations
		end

		-- Customize nvim-dap
		vim.fn.sign_define("DapBreakpoint", {
			text = style.icons.debug.breakpoint,
			-- texthl = "DiffChanged",
			linehl = "DapBreakpointLine",
			-- numhl = "DiffChange",
		})
		vim.fn.sign_define("DapBreakpointCondition", {
			text = style.icons.debug.breakpoint_conditional,
			-- texthl = "DiffChanged",
			linehl = "DapBreakpointConditionLine",
			-- numhl = "DiffChange",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = style.icons.debug.breakpoint_rejected,
			-- texthl = "DiffRemoved",
			linehl = "DapBreakpointRejectedLine",
			-- numhl = "DiffDelete",
		})

		vim.fn.sign_define("DapLogPoint", {
			text = style.icons.debug.logpoint,
			-- texthl = "DapBreakpointCondition",
			linehl = "DapLogPointLine",
			-- numhl = "DiffChange",
		})

		vim.fn.sign_define("DapStopped", {
			text = style.icons.debug.stopped,
			-- texthl = "DiffAdded",
			linehl = "DadStoppedLine",
			-- numhl = "DiffAdd",
		})
	end,
}
