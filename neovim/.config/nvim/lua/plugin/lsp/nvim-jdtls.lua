return {
  'mfussenegger/nvim-jdtls',

  defer = function()
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    local jdtls = require("jdtls")

    -- local noremap = { noremap = true }
    -- local silent_noremap = { noremap = true, silent = true }

    command_center.add({
      {
        description = "Jdtls Organize Imports",
        cmd = jdtls.organize_imports,
      }, {
        description = "Jdtls Extract Variable",
        cmd = jdtls.extract_variable,
      }, {
        description = "Jdtls Extract Constant",
        cmd = jdtls.extract_constant,
      }, {
        description = "Jdtls Test Neareast Method",
        cmd = jdtls.test_nearest_method,
      }, {
        description = "Jdtls Test Class",
        cmd = jdtls.test_class,
      }, {
        description = "Jdtls Update Config",
        cmd = "<CMD>JdtlsUpdateConfig<CR>",
      }
    })
  end
}
