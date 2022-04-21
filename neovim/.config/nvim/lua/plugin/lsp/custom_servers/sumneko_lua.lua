-- This function setups up sumnoko_lua properly
return function(opts)
  opts.settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      },
    }
  }
end

