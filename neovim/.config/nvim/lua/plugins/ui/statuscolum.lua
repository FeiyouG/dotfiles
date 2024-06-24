return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local conditions = require("heirline.conditions")
    local icons = settings.icons

    local align = { provider = "%=" }

    --- diagnostic signs
    local signs = {
      -- condition = function() return conditions.has_diagnostics() end,
      init = function(self)
        local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
          group = "*",
          lnum = vim.v.lnum,
        })

        if #signs == 0 or signs[1].signs == nil then
          self.sign = nil
          self.has_sign = false
          return
        end

        -- Filter out git signs
        signs = vim.tbl_filter(function(sign)
          return not vim.startswith(sign.group, "gitsigns")
        end, signs[1].signs)

        if #signs == 0 then
          self.sign = nil
        else
          self.sign = signs[1]
        end

        self.has_sign = self.sign ~= nil and self.sign.name ~= ""
        self.bufnr = vim.api.nvim_get_current_buf()
      end,

      provider = function(self)
        if self.has_sign then
          return vim.fn.sign_getdefined(self.sign.name)[1].text
        end
        return " "
      end,

      hl = function(self)
        if self.has_sign then
          if self.sign.group == "neotest-status" then
            local kws = vim.fn.split(self.sign.name, "_")
            if #kws == 2 then
              return "Neotest" .. string.upper(kws[2]:sub(1, 1)) .. kws[2]:sub(2, -1)
            end
            return "NeotestSkipped"
          elseif self.sign.group == "todo-signs" then
            local kws = vim.fn.split(self.sign.name, "-")
            if #kws == 3 then
              return "TodoFg" .. string.upper(kws[3])
            end
          end
          -- Everything else
          local hl = self.sign.name
          return (vim.fn.hlexists(hl) ~= 0 and hl)
        end
      end,
      on_click = {
        name = "sign_click",
        callback = function(self, ...)
          local _ = self.click_args(self, ...)
          vim.schedule(vim.diagnostic.open_float)
        end,
      },
    }

    local folds = {
      condition = function()
        return vim.v.virtnum == 0
      end,
      init = function(self)
        self.lnum = vim.v.lnum
        self.folded = vim.fn.foldlevel(self.lnum) > vim.fn.foldlevel(self.lnum - 1)
      end,
      {
        condition = function(self) return self.folded end,
        provider = function(self)
          if vim.fn.foldclosed(self.lnum) == -1 then
            return settings.icons.editor.statuscolumn.folds_open
          else
            return settings.icons.editor.statuscolumn.folds_closed
          end
        end,
        hl = function(self)
          if vim.fn.foldclosed(self.lnum) == -1 then
            return "StatusColumnUnfoldedIcon"
          else
            return "StatusColumnFoldedIcon"
          end
        end
      },
      {
        condition = function(self) return not self.folded end,
        provider = " ",
      },
      on_click = {
        name = "fold_click",
        callback = function(self, ...)
          local args = self.click_args(self, ...)
          local lnum = args.mousepos.line
          if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return end
          vim.cmd.execute("'" .. lnum .. "fold" .. (vim.fn.foldclosed(lnum) == -1 and "close" or "open") .. "'")
        end,
      },
    }

    local line_numbers = {
      init = function(self)
        self.mode = vim.fn.mode(1):sub(1, 1)
      end,
      provider = function()
        if vim.v.virtnum ~= 0 then
          return ""
        end

        if vim.v.relnum == 0 then
          return vim.v.lnum
        end

        return vim.v.relnum
      end,
    }

    local git_signs = {
      {
        condition = function()
          return not conditions.is_git_repo() or vim.v.virtnum ~= 0
        end,
        provider = "  ",
        hl = "GitSignsNoChange"
      },
      {
        condition = function()
          return conditions.is_git_repo() and vim.v.virtnum == 0
        end,
        init = function(self)
          local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
            group = "gitsigns_vimfn_signs_",
            id = vim.v.lnum,
            lnum = vim.v.lnum,
          })

          if
              #signs == 0
              or signs[1].signs == nil
              or #signs[1].signs == 0
              or signs[1].signs[1].name == nil
          then
            self.sign = nil
          else
            self.sign = signs[1].signs[1]
          end

          self.has_sign = self.sign ~= nil
        end,
        provider = function(self)
          if self.has_sign then
            return icons.editor.statuscolumn.gitsigns
          end
          return "  "
          -- return icons.editor.statuscolumn.gitsigns
        end,
        hl = function(self)
          if self.has_sign then
            return self.sign.name
          end
          return "GitSignsNoChange"
        end,
        on_click = {
          name = "gitsigns_click",
          callback = function(self, ...)
            local gitsigns_avail, gitsigns = pcall(require, "gitsigns")
            if gitsigns_avail then
              local _ = self.click_args(self, ...)
              vim.schedule(gitsigns.preview_hunk)
            end
          end,
        },
      },
    }

    opts.statuscolumn = {
      signs,
      align,
      line_numbers,
      folds,
      git_signs,
      static = {
        move_cursor_to_mouse_line = function()
          local mouse_pos = vim.fn.getmousepos()
          local lnum = mouse_pos.line
          local curosr_pos = { lnum, 0 }
          vim.api.nvim_win_set_cursor(mouse_pos.winid, curosr_pos)
          return lnum
        end,

        click_args = function(self, minwid, clicks, button, mods)
          local args = {
            minwid = minwid,
            clicks = clicks,
            button = button,
            mods = mods,
            mousepos = vim.fn.getmousepos(),
          }
          vim.api.nvim_set_current_win(args.mousepos.winid)
          vim.api.nvim_win_set_cursor(0, { args.mousepos.line, 0 })

          return args
        end,
      },
    }

    return opts
  end,
}
