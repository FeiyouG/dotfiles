return {
  name = "buffer",
  icon = Utils.icons.file.default,
  key = "<leader>b",
  color = "pink",
  mode = { "n", "x" },

  on_enter = function()
    vim.o.showtabline = 2
  end,

  on_exit = function()
    vim.o.showtabline = 0
  end,

  commands = function()
    local commands = {}

    if Utils.require("bufferline") then
      vim.list_extend(commands, {
        {
          desc = "Go to previous buffer",
          cmd = "<CMD>BufferPrevious<CR>",
          keys = { "n", "h", Utils.keymap.noremap }
        }, {
          desc = "Got to next buffer",
          cmd = "<CMD>BufferNext<CR>",
          keys = { "n", "l", Utils.keymap.noremap }
        }, {
          desc = "Move previous buffer",
          cmd = "<CMD>BufferMovePrevious<CR>",
          keys = { "n", "H", Utils.keymap.noremap }
        }, {
          desc = "Move next buffer",
          cmd = "<CMD>BufferMoveNext<CR>",
          keys = { "n", "L", Utils.keymap.noremap }
        }, {
          desc = "Pin buffer",
          cmd = "<CMD>BufferPin<CR>",
          keys = { "n", "p", Utils.keymap.noremap }
        }, {
          desc = "Chose buffer",
          cmd = "<CMD>BufferPick<CR>",
          keMoveys = { "n", "s", Utils.keymap.noremap }
        }, {
          desc = "Close buffer",
          cmd = "<CMD>BufferClose<CR>",
          keys = { "n", "c", Utils.keymap.noremap }
        }, {
          desc = "Order buffer by number",
          cmd = "<CMD>BufferOrderByBufferNumber<CR>",
        }, {
          desc = "Order buffer by directory",
          cmd = "<CMD>BufferOrderByBufferDirectory<CR>",
        }, {
          desc = "Order buffer by language",
          cmd = "<CMD>BufferOrderByBufferLanguage<CR>",
        }, {
          desc = "Order buffer by window number",
          cmd = "<CMD>BufferOrderByBufferWindowNumber<CR>",
        }
      })
    end

    -- Maximizer
    vim.list_extend(commands, {
      {
        desc = "Zoom in/out current buffer",
        cmd = "<CMD>MaximizerToggle!<CR>",
        keys = { "n", "z" }
      }
    })

    return commands
  end
}
