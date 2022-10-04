return {
  name = "buffer",
  icon = Utils.icons.file.default,
  key = "<leader>b",
  color = "pink",
  mode = { "n", "x" },

  on_enter = function()
    if Utils.require("lualine") then
      Utils.state.statusline.show_tabs = true
    end
  end,

  on_exit = function()
    if Utils.require("lualine") then
      Utils.state.statusline.show_tabs = false
    end
  end,

  commands = function()
    local commands = {
      {
        desc = "Delete current buffer and maintain layout",
        cmd = "<CMD>bdelete<CR>",
        keys = { "n", "d" }
      }, {
        desc = "Remove current pane",
        cmd = "<CMD>close<CR>",
        keys = { "n", "c" }
      }, {
        desc = "Go to 1st tabpage",
        cmd = "1gt",
        keys = { "n", "1" }
      }, {
        desc = "Go to 2nd tabpage",
        cmd = "2gt",
        keys = { "n", "2" }
      }, {
        desc = "Go to 3rd tabpage",
        cmd = "3gt",
        keys = { "n", "3" }
      }, {
        desc = "Go to 4th tabpage",
        cmd = "4gt",
        keys = { "n", "4" }
      }, {
        desc = "Go to 5th tabpage",
        cmd = "5gt",
        keys = { "n", "5" }
      }, {
        desc = "Go to 6th tabpage",
        cmd = "6gt",
        keys = { "n", "6" }
      }, {
        desc = "Go to 7th tabpage",
        cmd = "7gt",
        keys = { "n", "7" }
      }, {
        desc = "Go to 8th tabpage",
        cmd = "8gt",
        keys = { "n", "8" }
      }, {
        desc = "Go to 9th tabpage",
        cmd = "9gt",
        keys = { "n", "9" }
      }, {
        desc = "Go to previous tabpage",
        cmd = "<CMD>tabprevious<CR>",
        keys = { "n", "h" }
      }, {
        desc = "Go to next tabpage",
        cmd = "<CMD>tabnext<CR>",
        keys = { "n", "l" }
      },
    }

    if Utils.require("windows") then
      vim.list_extend(commands, {
        {
          desc = "Maximize current buffer with animation",
          cmd = "<CMD>WindowsMaximize<CR>",
          keys = { "n", "z" },
        }, {
          desc = "Maximize current buffer horizontally with animation",
          cmd = "<CMD>WindowsMaximizeHorizontally<CR>",
          keys = { "n", "|" },
        }, {
          desc = "Maximize current buffer Vertically with animation",
          cmd = "<CMD>WindowsMaximizeVertically<CR>",
          keys = { "n", "_" },
        }, {
          desc = "Equalize all buffers with animation",
          cmd = "<CMD>WindowsEqualize<CR>",
          keys = { "n", "=" },
        }, {
          desc = "Toggle Sliding buffer width",
          cmd = "<CMD>WindowsToggleAutowidth<CR>",
          keys = { "n", "w" },
        },
      })
    end

    if Utils.require("cybu") then
      vim.list_extend(commands, {
        {
          desc = "Select previous buffer",
          cmd = "<Plug>(CybuPrev)",
          keys = {
            { "n", "k", Utils.keymap.remap }
          },
        }, {
          desc = "Select previous buffer",
          cmd = "<Plug>(CybuNext)",
          keys = {
            { "n", "j", Utils.keymap.remap }
          },
        },
      })
    end

    -- if Utils.require("bufferline") then
    --   vim.list_extend(commands, {
    --     {
    --       desc = "Go to previous buffer",
    --       cmd = "<CMD>BufferPrevious<CR>",
    --       keys = { "n", "h", Utils.keymap.noremap }
    --     }, {
    --       desc = "Got to next buffer",
    --       cmd = "<CMD>BufferNext<CR>",
    --       keys = { "n", "l", Utils.keymap.noremap }
    --     }, {
    --       desc = "Move previous buffer",
    --       cmd = "<CMD>BufferMovePrevious<CR>",
    --       keys = { "n", "H", Utils.keymap.noremap }
    --     }, {
    --       desc = "Move next buffer",
    --       cmd = "<CMD>BufferMoveNext<CR>",
    --       keys = { "n", "L", Utils.keymap.noremap }
    --     }, {
    --       desc = "Pin buffer",
    --       cmd = "<CMD>BufferPin<CR>",
    --       keys = { "n", "p", Utils.keymap.noremap }
    --     }, {
    --       desc = "Chose buffer",
    --       cmd = "<CMD>BufferPick<CR>",
    --       keMoveys = { "n", "s", Utils.keymap.noremap }
    --     }, {
    --       desc = "Close buffer",
    --       cmd = "<CMD>BufferClose<CR>",
    --       keys = { "n", "c", Utils.keymap.noremap }
    --     }, {
    --       desc = "Order buffer by number",
    --       cmd = "<CMD>BufferOrderByBufferNumber<CR>",
    --     }, {
    --       desc = "Order buffer by directory",
    --       cmd = "<CMD>BufferOrderByBufferDirectory<CR>",
    --     }, {
    --       desc = "Order buffer by language",
    --       cmd = "<CMD>BufferOrderByBufferLanguage<CR>",
    --     }, {
    --       desc = "Order buffer by window number",
    --       cmd = "<CMD>BufferOrderByBufferWindowNumber<CR>",
    --     }
    --   })
    -- end

    -- Maximizer
    -- vim.list_extend(commands, {
    --   {
    --     desc = "Zoom in/out current buffer",
    --     cmd = "<CMD>MaximizerToggle!<CR>",
    --     keys = { "n", "z" }
    --   }
    -- })

    return commands
  end
}
