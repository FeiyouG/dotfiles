vim.cmd "set completeopt=menu,menuone,noselect"

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local luasnip = require("luasnip")
local cmp = require "cmp"
local kind_icons = {
  -- Text = "",
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "",
  Interface = "ﰮ",
  Module = "",
  Property = "ﴯ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- local kind_icons = {
--   Text = "",
--   Method = "",
--   Function = "",
--   Constructor = "",
--   Field = "ﰠ",
--   Variable = "",
--   Class = "ﴯ",
--   Interface = "",
--   Module = "",
--   Property = "ﰠ",
--   Unit = "塞",
--   Value = "",
--   Enum = "",
--   Keyword = "",
--   Snippet = "",
--   Color = "",
--   File = "",
--   Reference = "",
--   Folder = "",
--   EnumMember = "",
--   Constant = "",
--   Struct = "פּ",
--   Event = "",
--   Operator = "",
--   TypeParameter = "",
-- }


cmp.setup {
  -- Don't preselect item
  preselect = cmp.PreselectMode.Item,

  -- completion = {
  --   autocomplete = false,
  -- },

  mapping = {

    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {"i", "s"}),

    ["<C-p>"] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {"i", "s"}),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       elseif has_words_before() then
--         cmp.complete()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),

--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { "i", "s" }),

    -- Select the completion item, excluding preselected
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    ['<Up>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 5, },
    { name = "luasnip", max_item_count = 5,},
  }, {
    { name = "buffer", max_item_count = 4, },
    { name = "path", max_item_count = 3, },
    {name = "dictionary", max_item_count = 5, },
  }),

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },


  formatting = {
    format = function(entry, vim_item)
      -- Show kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)

      -- Show source
      vim_item.menu = ({
        buffer = "[BUFFER]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[API]",
        path = "[PATH]",
        luasnip = "[SNIPPET]",
        dictionary = "[DICTIONARY]",
        nvim_lsp_document_symbol = "[SYMBOL]"
      })[entry.source.name]

      -- Custumize padding
      vim_item.abbr = ' ' .. vim_item.abbr

      return vim_item
    end
  },

    experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }, -- trigger by "/@"
  }, {
    { name = 'buffer' }
  })
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
