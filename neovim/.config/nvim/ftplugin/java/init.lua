local utils = require("utils")
local jdtls_config = require("plugin/lsp/servers/jdtls")

-- Set common server configs
jdtls_config.capabilities = utils.lsp.capabilities

-- MARK: Starts a new client & server,
require('jdtls').start_or_attach(jdtls_config)

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
vim.opt_local.tabstop = 4 -- Bumber of columns occupied by a tab character
vim.opt_local.shiftwidth = 4 -- Width for autoidnents
vim.opt_local.softtabstop = 4 -- How far cursor travels by pressing tab
vim.opt_local.expandtab = true -- Converts tab to whitespace
vim.opt_local.autoindent = true -- Indent a new line the same amound as the line before it
