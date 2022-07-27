return {
  'mfussenegger/nvim-jdtls',

  commands = function()
    local jdtls = require("jdtls")

    return {
      {
        description = "Jdtls Organize Imports",
        cmd = jdtls.organize_imports,
        category = "lsp",
      }, {
        description = "Jdtls Extract Variable",
        cmd = jdtls.extract_variable,
        category = "lsp",
      }, {
        description = "Jdtls Extract Constant",
        cmd = jdtls.extract_constant,
        category = "lsp",
      }, {
        description = "Jdtls Test Neareast Method",
        cmd = jdtls.test_nearest_method,
        category = "lsp",
      }, {
        description = "Jdtls Test Class",
        cmd = jdtls.test_class,
        category = "lsp",
      }, {
        description = "Jdtls Update Config",
        cmd = "<CMD>JdtlsUpdateConfig<CR>",
        category = "lsp",
      }
    }
  end
}
