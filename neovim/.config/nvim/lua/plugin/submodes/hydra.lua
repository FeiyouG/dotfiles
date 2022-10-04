return {
  'anuvyklack/hydra.nvim',

  defer = function()
    local modes = require("plugin/submodes/modes")
    local hydra = require("hydra")
    local command_center = Utils.require("command_center",
      "submodes requires command_center to register keybindings")

    -- Create all submodes
    for _, submode in ipairs(modes) do

      if not Utils.is_callable(submode.commands) then
        Utils.notify.warn_once(submode.name .. " submode",
          submode.name .. " submode cannot be created;",
          "`submode.command` is not callable.")
        goto continue
      end


      local submode_cmd = submode.commands()

      if type(submode_cmd) ~= "table" then
        Utils.notify.warn_once(submode.name .. " submode",
          submode.name .. " submode cannot be created;",
          "Expecting `submode.command()` to return a table, but was " .. type(submode_cmd))
        goto continue
      end

      vim.list_extend(submode_cmd, {
        {
          desc = "show all commands in " .. submode.name .. " mode",
          cmd = "<CMD>Telescope command_center category=" .. submode.name .. "<CR>",
          keys = { "n", "?", Utils.keymap.noremap },
        }, {
          desc = "Exit " .. submode.name .. " mode",
          cmd = submode.key,
          keys = {
            { { "n", "x" }, submode.key, Utils.keymap.nowait },
            { { "n", "x" }, "<ESC>", Utils.keymap.nowait }
          },
          hydra_head_args = { exit = true }
        }
      })

      local hydra_heads = command_center and command_center.converter.to_hydra_heads(submode_cmd) or {}

      hydra({
        name = submode.name,
        config = {
          buffer = bufnr,
          color = submode.color,
          invoke_on_body = true,
          hint = false,
          on_enter = submode.on_enter,
          on_exit = submode.on_exit
        },
        mode = { "n", "x" },
        body = submode.key,
        heads = hydra_heads,
      })
      ::continue::
    end
  end
}
