return function()
  local command_center = Utils.require("command_center")

  local buf_mode_name = "Buffer"
  local buf_mode_icon = Utils.icons.file.default
  local buf_mode_key = "<leader>b"

  local buf_mode_cmd = {
    {
      desc = "show all commands in buffer mode",
      cmd = "<CMD>Telescope command_center category=" .. buf_mode_name .. "<CR>",
      keys = { "n", "?", Utils.keymap.noremap },
      mode = Utils.keymap.cc_mode.SET
    }, {
      desc = "Exit buffer mode",
      cmd = buf_mode_key,
      keys = { "n", buf_mode_key, Utils.keymap.nowait },
      hydra_head_args = { exit = true }
    }
  }

  if Utils.require("bufferline") then
    vim.list_extend(buf_mode_cmd, {
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
  vim.list_extend(buf_mode_cmd, {
    {
      desc = "Zoom in/out current buffer",
      cmd = "<CMD>MaximizerToggle!<CR>",
      keys = { "n", "z" }
    }
  })


  -- MARK: Create hydra
  return {
    name = buf_mode_name,
    config = {
      buffer = bufnr,
      color = "pink",
      invoke_on_body = true,
      hint = false,
      on_enter = function()
        vim.o.showtabline = 2
        if command_center then
          command_center.add(buf_mode_cmd, {
            mode = command_center.mode.ADD,
            category = buf_mode_name,
          })
        end
        Utils.notify.enter_submode(buf_mode_name, buf_mode_icon)
      end,
      on_exit = function()
        if command_center then
          command_center.remove(buf_mode_cmd, {
            mode = command_center.mode.ADD,
            category = buf_mode_name,
          })
        end
        Utils.notify.exit_submode(buf_mode_name, buf_mode_icon)
      end,
    },
    mode = { "n", "x" },
    body = buf_mode_key,
    heads = command_center and command_center.converter.to_hydra_heads(buf_mode_cmd) or {},
  }
end
