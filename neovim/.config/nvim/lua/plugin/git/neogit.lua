return {
  'TimUntersberger/neogit',

  requires = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim'
  },

  config = function()
    local neogit = require("neogit")

    local icons = Utils.const.icons

    neogit.setup {
      disable_signs = false,
      disable_hint = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      disable_insert_on_commit = true,
      auto_refresh = false,
      disable_builtin_notifications = false,
      use_magit_keybindings = false,
      kind = "tab",
      commit_popup = {
        kind = "split",
      },
      popup = {
        kind = "split",
      },
      signs = {
        -- { CLOSED, OPENED }
        section = {icons.folder.indicator_closed, icons.folder.indicator_open},
        item = {icons.folder.indicator_closed, icons.folder.indicator_open},
        hunk = {icons.folder.indicator_closed, icons.folder.indicator_open},
      },
      integrations = {
        diffview = true
      },
      -- Setting any section to `false` will make the section not render at all
      sections = {
        untracked = {
          folded = false
        },
        unstaged = {
          folded = false
        },
        staged = {
          folded = false
        },
        stashes = {
          folded = true
        },
        unpulled = {
          folded = true
        },
        unmerged = {
          folded = false
        },
        recent = {
          folded = true
        },
      },
      -- override/add mappings
      mappings = {
        -- modify status buffer mappings
        status = {
          ["s"] = "Stage",
          ["u"] = "Unstage",
          ["<Return>"] = "Toggle",
          ["q"] = "Close",
          ["<leader>r"] = "RefreshBuffer"
        }
      }
    }
  end
}
