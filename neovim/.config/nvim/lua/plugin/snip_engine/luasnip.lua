return {
  'L3MON4D3/LuaSnip',

  config = function()
    ---- MARK: Declaration of variabels
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")

    ---- MARK: General Configuration ----
    luasnip.config.set_config {
      -- This one is cool cause if you have dynamic snippets, it updates as you type!
      -- updateevents = "TextChanged,TextChangedI",
      updateevents = "TextChanged",

      -- Autosnippets:
      enable_autosnippets = true,

      -- Crazy highlights!!
      -- #vid3
      -- ext_opts = nil,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "<-", "Error" } },
          },
        },
      },
    }

    require("luasnip.loaders.from_vscode").load()
    require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snippets" } })
  end
}
