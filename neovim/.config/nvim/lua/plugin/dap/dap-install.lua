return {
  "Pocco81/dap-buddy.nvim",

  commit = "24923c3819a450a772bb8f675926d530e829665f",

  config = function()
    local dap_install = require("dap-install")
    local utils = require("utils")

    dap_install.setup({
      installation_path = utils.path.concat(vim.fn.stdpath("data"), "dap/")
    })


  end
}
