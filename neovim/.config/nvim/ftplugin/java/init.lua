local jdtls = require("jdtls")
local jdtls_config = require("plugin.lsp.servers").jdtls.java

-- Set common server configs
jdtls_config.capabilities = Utils.lsp.capabilities

-- MARK: Starts a new client & server,
jdtls.start_or_attach(jdtls_config)

-- MARK: Amazon + Bemol
local root_dir = require('jdtls.setup').find_root({ "packageInfo" }, "Config") -- Project root directory
if root_dir then
  local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r");
  if file then
    for line in file:lines() do
      vim.lsp.buf.add_workspace_folder(line)
    end
    file:close()
  end
end

-- MARK: Override java style
vim.opt_local.tabstop = 4        -- Bumber of columns occupied by a tab character
vim.opt_local.shiftwidth = 4     -- Width for autoidnents
vim.opt_local.softtabstop = 4    -- How far cursor travels by pressing tab
vim.opt_local.expandtab = true   -- Converts tab to whitespace
vim.opt_local.autoindent = true  -- Indent a new line the same amound as the line before it


-- MARK: Add buffer-specific keybindings
local commands = {
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
}

local command_center = Utils.require("command_center")
if command_center then
  command_center.add(commands, {
    category = "lsp",
    keys_opts = { buffer = true }
  })
end
