local M = {
  'hrsh7th/nvim-cmp',
  requires = {
    'nvim-lua/plenary.nvim'
  }
}

M.config = function()
  local has_luasnip, luasnip = pcall(require, "luasnip")
  local cmp = require("cmp")

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

  local mapping = {
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if not has_luasnip then return end
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if not has_luasnip then return end
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    -- Select the completion item, excluding preselected
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

  }

  cmp.setup {
    -- Don't preselect item
    preselect = cmp.PreselectMode.Item,

    -- mapping = cmp.mapping.preset.insert(mapping),
    mapping = mapping,

    window = {
      documentation = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        winhighlight = "FloatBorder:TelescopePromptBorder,CursorLine:TelescopeSelection,Search:None"
      },
      completion = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        winhighlight = "FloatBorder:TelescopePromptBorder,CursorLine:TelescopeSelection,Search:None"
      }
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp', },
      { name = "luasnip", },
      { name = "path", },
    }, {
      { name = "buffer", },
      { name = 'nvim_lsp_signature_help' },
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
          -- dictionary = "[DICTIONARY]",
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

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = "buffer", },
      { name = "path", },
    })
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' }, -- trigger by "/@"
    }, {
      { name = 'buffer' }
    })
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
end

return M
