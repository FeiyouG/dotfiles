return {
  'folke/trouble.nvim',

  config = function()
    local trouble = require("trouble")
    local utils = require("utils")

    local icons = utils.constants.icons

    trouble.setup({
      position = "bottom", -- position of the list can be: bottom, top, left, right
      height = 10, -- height of the trouble list when position is top or bottom
      width = 50, -- width of the list when position is left or right
      icons = true, -- use devicons for filenames
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      fold_open = icons.folder.open, -- icon used for open folds
      fold_closed = icons.folder.closed, -- icon used for closed folds
      group = true, -- group results by file
      padding = true, -- add an extra new line on top of the list
      action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
      },
      indent_lines = true, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = false, -- automatically close the list when you have no diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
      signs = {
        -- icons / text used for a diagnostic
        error = icons.diagnostic.error,
        warning = icons.diagnostic.warning,
        hint = icons.diagnostic.hint,
        information = icons.diagnostic.information,
        other = icons.diagnostic.other,
      },
      use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    })
  end,

  commands = function()
    local trouble = require("trouble")
    local utils = require("utils")

    return {
      {
        description = "Toggle trouble",
        cmd = "<CMD>TroubleToggle<CR>",
        keybindings = { "n", "<leader>xx", utils.keymap.noremap },
      }, {
        description = "Toggle trouble (worksapce diagnostic)",
        cmd = "<CMD>TroubleToggle workspace_diagnostics<CR>",
        keybindings = { "n", "<leader>xw", utils.keymap.noremap },
      }, {
        description = "Toggle trouble (document diagnostic)",
        cmd = "<CMD>TroubleToggle document_diagnostics<CR>",
        keybindings = { "n", "<leader>xd", utils.keymap.noremap },
      }, {
        description = "Toggle trouble (quickfix list)",
        cmd = "<CMD>TroubleToggle quickfix<CR>",
        keybindings = { "n", "<leader>xq", utils.keymap.noremap },
      }, {
        description = "Toggle trouble (location list)",
        cmd = "<CMD>TroubleToggle loclist <CR>",
        keybindings = { "n", "<leader>xl", utils.keymap.noremap },
      }, {
        description = "Next item in Trouble",
        cmd = function() trouble.next({ skip_groups = true, jump = true }) end,
        keybindings = { "n", "<leader>xn", utils.keymap.noremap },
      }, {
        description = "Previous item in Trouble",
        cmd = function() trouble.previous({ skip_groups = true, jump = true }) end,
        keybindings = { "n", "<leader>xp", utils.keymap.noremap },
      }
    }
  end
}
