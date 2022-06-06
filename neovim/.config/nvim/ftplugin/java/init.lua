local utils = require("utils")
local jdtls_config = require("plugin/lsp/servers/jdtls")

-- Set common server configs
jdtls_config.capabilities = utils.lsp.capabilities

-- MARK: Starts a new client & server,
require('jdtls').start_or_attach(jdtls_config)
