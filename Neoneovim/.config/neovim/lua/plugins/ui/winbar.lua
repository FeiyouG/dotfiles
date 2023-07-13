return {
  "rebelot/heirline.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  opts = function(_, opts)
    local cond = require("heirline.conditions")
    local icons = settings.icons
    local colors = settings.colors

    local divider_secondary_left = {
      provider = "",
      hl = { fg = colors.statusline.snd_bg, bg = colors.statusline.trd_bg, bold = false },
    }

    local filename = {
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
      end,
      -- hl = { bg = colors.statusline.snd_bg },
      hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = colors.mode[mode], bg = colors.statusline.snd_bg }
      end,
      {
        provider = " ",
      },
      {
        provider = function()
          -- local bufname = vim.fn.expand("%:t")
          -- return bufname == "" and "No Name" or bufname
          return vim.fn.expand("%:t")
        end,
        -- hl = function(self)
        --   local mode = self.mode:sub(1, 1) -- get only the first mode character
        --   return { fg = colors.mode[mode], bg = colors.statusline.snd_bg }
        -- end,
      },
      -- Modifier
      {
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = " " .. icons.fs.file.indicator.modified,
          -- hl = { fg = colors.orange },
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = " " .. icons.fs.file.indicator.readonly,
        },
      },
      {
        provider = " ",
      },
      divider_secondary_left,
    }

    local navic = {
      condition = function()
        return require("nvim-navic").is_available()
      end,
      hl = { fg = colors.none, bg = colors.statusline.trd_bg },
      update = "CursorMoved",
      init = function(self)
        local data = require("nvim-navic").get_data() or {}
        local children = {}
        -- create a child for each level
        for i, d in ipairs(data) do
          -- encode line and column numbers into a single integer
          local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
          local child = {
            {
              provider = d.icon,
              hl = self.type_hl[d.type],
            },
            {
              -- escape `%`s (elixir) and buggy default separators
              provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
              -- highlight icon only or location name as well
              -- hl = self.type_hl[d.type],

              on_click = {
                -- pass the encoded position through minwid
                minwid = pos,
                callback = function(_, minwid)
                  -- decode
                  local line, col, winnr = self.dec(minwid)
                  vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
                end,
                name = "heirline_navic",
              },
            },
          }
          -- add a separator only if needed
          if #data > 1 and i < #data then
            table.insert(child, {
              provider = " > ",
              hl = { fg = colors.gray },
            })
          end
          table.insert(children, child)
        end
        -- instantiate the new child, overwriting the previous one
        self.child = self:new(children, 1)
      end,
      -- evaluate the children containing navic components
      provider = function(self)
        return " " .. self.child:eval()
      end,
      on_click = {
        name = "navic-click",
        callback = function(self, ...)
          local navbuddy_avail, navbuddy = pcall(require, "navbuddy")
          if not navbuddy_avail then
            return
          end

          vim.schedule(function()
            navbuddy.open(0)
          end)
        end,
      },
      static = {
        -- create a type highlight map
        type_hl = {
          File = "Directory",
          Module = "@include",
          Namespace = "@namespace",
          Package = "@include",
          Class = "@structure",
          Method = "@method",
          Property = "@property",
          Field = "@field",
          Constructor = "@constructor",
          Enum = "@field",
          Interface = "@type",
          Function = "@function",
          Variable = "@variable",
          Constant = "@constant",
          String = "@string",
          Number = "@number",
          Boolean = "@boolean",
          Array = "@field",
          Object = "@type",
          Key = "@keyword",
          Null = "@comment",
          EnumMember = "@field",
          Struct = "@structure",
          Event = "@keyword",
          Operator = "@operator",
          TypeParameter = "@type",
        },
        -- bit operation dark magic, see below...
        enc = function(line, col, winnr)
          return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,
        -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
        dec = function(c)
          local line = bit.rshift(c, 16)
          local col = bit.band(bit.rshift(c, 6), 1023)
          local winnr = bit.band(c, 63)
          return line, col, winnr
        end,
      },
    }

    opts.winbar = {
      filename,
      navic,
    }

    -- Disable winbar on ft
    opts.opts = opts.opts or {}
    opts.opts.disable_winbar_cb = function(args)
      return cond.buffer_matches(settings.ft.exclude_winbar, args.buf)
    end

    return opts
  end,
}
