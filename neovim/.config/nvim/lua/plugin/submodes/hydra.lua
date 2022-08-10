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
          keys = { "n", submode.key, Utils.keymap.nowait },
          hydra_head_args = { exit = true }
        }
      })

      local hydra_heads = command_center and command_center.converter.to_hydra_heads(submode_cmd) or {}

      hydra({
        name = submode.name,
        config = {
          buffer = bufnr,
          color = submode.color or "pink",
          invoke_on_body = true,
          hint = false,
          on_enter = function()
            if Utils.is_callable(submode.on_enter) then
              submode.on_enter()
            end

            if command_center then
              command_center.add(submode_cmd, {
                mode = command_center.mode.ADD,
                category = submode.name,
              })
            end
            Utils.notify.enter_submode(submode.name, submode.icon)
          end,
          on_exit = function()
            if Utils.is_callable(submode.on_exit) then
              submode.on_exit()
            end

            if command_center then
              command_center.remove(submode_cmd, {
                mode = command_center.mode.ADD,
                category = submode.name,
              })
            end
            Utils.notify.exit_submode(submode.name, submode.icon)
          end,
        },
        mode = { "n", "x" },
        body = submode.key,
        heads = hydra_heads,
      })
      ::continue::
    end
  end
}
