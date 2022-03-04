local settings = {
  Lua = {
    diagnostics = {
      globals = { 'vim', 'use' }
    },
  }
}

-- This function setups up sumnoko_lua properly
return function(opts)
  opts.settings = settings
end

