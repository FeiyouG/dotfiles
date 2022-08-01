return {
  'anuvyklack/hydra.nvim',

  defer = function()
    local modes = require("plugin/submodes/modes")
    local hydra = require("hydra")

    -- Create all submodes
    for _, submode in ipairs(modes) do
      local submode_config = submode()
      hydra(submode_config)
    end
  end
}
