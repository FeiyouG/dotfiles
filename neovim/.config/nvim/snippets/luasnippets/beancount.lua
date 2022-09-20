---- MARK: Declaring Short Hand Variables ----
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.match
local l = extras.lambda
local dl = extras.dynamic_lambda
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

return {
  -- s({
  --   trig = "open directive",
  --   name = "Open an account",
  -- }, {
  --   extras.partial(os.date, "%Y-%m-%d"), t(" open "),
  --   c(1, {
  --     t("Assets"),
  --     t("Liabilities"),
  --     t("Equity"),
  --     t("Income"),
  --     t("Expenses"),
  --   }),
  --   t(":"),
  --   i(2, "Account"),
  --   sn(2, {
  --     t(" "),
  --     i(1, "[Commodity]"),
  --     t(" "),
  --     c(2, {
  --       t("[BookingMethod]"),
  --       t("STRICT"),
  --       t("FIFO"),
  --       t("LIFO")
  --       t("NONE"),
  --     })
  --   }, {
  --     callbacks = {
  --       [-1] = {
  --         [events.leave] = function(node, _)
  --           local text = node:get_text()[1]
  --           text = text:gsub(" %[Commodity%]", "")
  --           text = text:gsub(" %[BookingMethod%]", "")
  --           ls.set_text(node, text)
  --         end
  --       },
  --     }
  --   }),
  --   i(0)
  -- }),
  --
  -- s({
  --   trig = "close directive",
  --   name = "Close an account",
  -- }, {
  --   extras.partial(os.date, "%Y-%m-%d"), t(" close "),
  --   c(1, {
  --     t("Assets"),
  --     t("Liabilities"),
  --     t("Equity"),
  --     t("Income"),
  --     t("Expenses"),
  --   }),
  --   t(":"),
  --   i(2, "Account"),
  -- }),
  --
  -- s({
  --   trig = "Commodity directive",
  --   name = "Attach metadata to a commodity"
  -- }, {
  --   extras.partial(os.date, "%Y-%m-%d"), t(" commodity "),
  --   i(1, "CommoditySymbol"),
  --   t({ "", "  " }),
  --   i(2, "name"), t(": \""), i(2, "CommodityName"), t("\""),
  --   t({ "", "  " }),
  --   i(3, "asset-class"), t(": \""),
  --   c(4, {
  --     t("[AssetClass]"),
  --     t("cash"),
  --     t("stock"),
  --     t("reward points"),
  --   }), t("\""),
  --   i(0)
  -- }),
  --
  -- s({
  --   trig = "Transaction directive",
  --   name = "Add a transaction"
  -- }, {
  --   extras.partial(os.date, "%Y-%m-%d"), t(" "),
  --   c(1, {
  --     t("*"),
  --     t("!")
  --   }),
  --   sn(2, {
  --     t(" [[\""),
  --     i(1, "Payee"), t("\"] \""),
  --     i(2, "Narration"), t("\"]"),
  --   }, {
  --     callbacks = {
  --       [-1] = {
  --         [events.leave] = function(node, _)
  --           local text = node:get_text()[1]
  --           text = text:gsub(' %[%["Payee"%] "Narration"%]', "")
  --           text = text:gsub('%[%["(%a*)"%] "Narration"%]', '"%1" ""')
  --           text = text:gsub('%[%["Payee"%] "(%a*)"%]', '"%1"')
  --           text = text:gsub('%[%["(%a*)"%] "(%a*)"%]', '"%1" "%2"')
  --           ls.set_text(node, text)
  --         end
  --       }
  --     }
  --   }),
  --   t({ "", "  " }),
  --   i(3, "Account"), t(" "),
  --   i(4, "Cost"), t(" "),
  --   i(5, "Commodity"), t(" "),
  --   sn(6, {
  --     c(1, {
  --       sn(nil, {
  --         t(" [@ "),
  --         i(1, "Price"),
  --         i(2, "Commodity"),
  --         t("]"),
  --       }),
  --       sn(nil, {
  --         t(" [@@ "),
  --         i(1, "Price"),
  --         i(2, "Commodity"),
  --         t("]"),
  --       })
  --     })
  --   }, {
  --     callbacks = {
  --       [events.leave] = function(node, _)
  --         local text = node:get_text()[1]
  --         text = text:gsub(' %[@+ "Price" "Commodity%]', "")
  --         ls.set_text(node, text)
  --       end
  --     }
  --   }),
  --   i(0)
  -- }),
  --
  -- s({
  --   trig = "key-value pair",
  --   name = "Insert a key-value pair for a directive",
  -- }, {
  --   i(1, "key"), t(": \""), i(2, "value"), t("\""), i(0)
  -- })
}
