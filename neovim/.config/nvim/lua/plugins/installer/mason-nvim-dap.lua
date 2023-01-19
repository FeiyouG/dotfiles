return {
  "jayp0521/mason-nvim-dap.nvim",

  event = { "VeryLazy" },

  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },

  config = function()
    local mason_nvim_dap = require("mason-nvim-dap")

    mason_nvim_dap.setup({
      -- A list of adapters to install if they're not already installed.
      -- This setting has no relation with the `automatic_installation` setting.
      ensure_installed = {},
      -- Run `require("dap").setup`.
      -- Will automatically install masons tools based on selected adapters in `dap`.
      automatic_installation = true,
    })
  end,
}
