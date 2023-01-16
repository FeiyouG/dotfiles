return {
  'anuvyklack/hydra.nvim',

  defer = function()
    local modes = require("plugin.submodes.modes")
    local hydra = require("hydra")

    local commander = Utils.require("commander",
      "submodes requires commander to register keybindings")

    if not commander then return end
    local key_prefix = "<leader><leader>"

    -- Create all submodes
    for _, submode in ipairs(modes) do

      local submode_cmd = {}
      local submode_key = key_prefix .. submode.key

      if Utils.is_callable(submode.commands) then
        submode_cmd = submode.commands()
      else
        submode_cmd = submode.commands
      end

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
          cmd = submode_key,
          keys = {
            { { "n", "x" }, submode_key, Utils.keymap.nowait },
            { { "n", "x" }, "<ESC>", Utils.keymap.nowait }
          },
          hydra_head_args = { exit = true }
        }
      })

      local hydra_heads = commander and commander.converter.to_hydra_heads(submode_cmd) or {}

      hydra({
        name = submode.name,
        mode = submode.mode,
        body = submode_key,
        heads = hydra_heads,
        config = {
          buffer = bufnr,
          color = submode.color,
          invoke_on_body = true,
          hint = false,
          on_enter = function()
            if Utils.is_callable(submode.on_enter) then
              submode.on_enter()
            end

            if commander then
              commander.add(submode_cmd, {
                mode = commander.mode.ADD,
                category = submode.name,
              })
            end
            local message = submode.icon .. " " .. submode.name .. " submode"
            Utils.notify.minimal(message, vim.log.levels.INFO, { hide_from_history = true, })
          end,
          on_exit = function()
            if Utils.is_callable(submode.on_exit) then
              submode.on_exit()
            end

            if commander then
              commander.remove(submode_cmd, {
                mode = commander.mode.ADD,
                category = submode.name,
              })
            end
          end,
        },
      })
      ::continue::
    end
  end
}
