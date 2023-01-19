return {
  "monaqa/dial.nvim",

  keys = {
    { "<C-x>", mode = { "n", "v" } },
    { "<C-a>", mode = { "n", "v" } },
    { "g<C-x>", mode = { "v" } },
    { "g<C-a>", mode = { "v" } },
  },

  config = function()
    local augend = require("dial.augend")
    local default_group = {
      augend.integer.alias.decimal, -- decimal natural number                           ; e.g. `0`, `1`, ..., `9`, `10`, `11`, ...
      augend.integer.alias.decimal_int, -- decimal integer (including negative number)      ; e.g. `0`, `314`, `-1592`, ...
      augend.integer.alias.hex, -- hex natural number                               ; e.g. `0x00`, `0x3f3f`, ...
      augend.integer.new({ -- uppercase hex number                             ; e.g. 0x1A1A, 0xEEFE, ...
        radix = 16,
        prefix = "0x",
        natural = true,
        case = "upper",
      }),
      augend.integer.alias.octal, -- octal natural number                             ; e.g. `0o00`, `0o11`, `0o24`, ...
      augend.integer.alias.binary, -- binary natural number                            ; e.g. `0b0101`, `0b11001111`, ...
      augend.date.alias["%Y/%m/%d"], -- Date in the format `%Y/%m/%d` (`0` padding)      ; e.g. `2021/01/23`, ...
      augend.date.alias["%m/%d/%Y"], -- Date in the format `%m/%d/%Y` (`0` padding)      ; e.g. `23/01/2021`, ...
      augend.date.alias["%d/%m/%Y"], -- Date in the format `%d/%m/%Y` (`0` padding)      ; e.g. `01/23/2021`, ...
      augend.date.alias["%m/%d/%y"], -- Date in the format `%m/%d/%y` (`0` padding)      ; e.g. `01/23/21`, ...
      augend.date.alias["%d/%m/%y"], -- Date in the format `%d/%m/%y` (`0` padding)      ; e.g. `23/01/21`, ...
      augend.date.alias["%m/%d"], -- Date in the format `%m/%d` (`0` padding)         ; e.g. `01/04`, `02/28`, `12/25`, ...
      augend.date.alias["%-m/%-d"], -- Date in the format `%-m/%-d` (no paddings)       ; e.g. `1/4`, `2/28`, `12/25`, ...
      augend.date.alias["%Y-%m-%d"], -- Date in the format `%Y-%m-%d` (`0` padding)      ; e.g. `2021-01-04`, ...
      augend.date.alias["%d.%m.%Y"], -- Date in the format `%d.%m.%Y` (`0` padding)      ; e.g. `23.01.2021`, ...
      augend.date.alias["%d.%m.%y"], -- Date in the format `%d.%m.%y` (`0` padding)      ; e.g. `23.01.21`, ...
      augend.date.alias["%d.%m."], -- Date in the format `%d.%m.` (`0` padding)        ; e.g. `04.01.`, `28.02.`, `25.12.`, ...
      augend.date.alias["%-d.%-m."], -- Date in the format `%-d.%-m.` (no paddings)      ; e.g. `4.1.`, `28.2.`, `25.12.`, ...
      augend.date.alias["%Y年%-m月%-d日"], -- Date in the format `%Y年%-m月%-d日` (no paddings); e.g. `2021年1月4日`, ...
      augend.date.alias["%Y年%-m月%-d日(%ja)"], -- Date in the format `%Y年%-m月%-d日(%ja)`         ; e.g. `2021年1月4日(月)`, ...
      augend.date.alias["%H:%M:%S"], -- Time in the format `%H:%M:%S`                    ; e.g. `14:30:00`, ...
      augend.date.alias["%H:%M"], -- Time in the format `%H:%M`                       ; e.g. `14:30`, ...
      augend.constant.alias.bool, -- elements in boolean algebra (`true` and `false`) ; e.g. `true`, `false`
      augend.constant.alias.alpha, -- Lowercase alphabet letter (word)                 ; e.g. `a`, `b`, `c`, ..., `z`
      augend.constant.alias.Alpha, -- Uppercase alphabet letter (word)                 ; e.g. `A`, `B`, `C`, ..., `Z`
      augend.constant.new({ -- Number in English
        elements = { "zero", "one", "two", "three", "four", "five", "six", "seven", "nine" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({ -- Number in English (Capitalized)
        elements = { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Nine" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({ -- Number in English (Upper Case)
        elements = { "ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "NINE" },
        WORD = true,
        cyclic = true,
      }),
      augend.constant.new({ -- Number in Chinese
        elements = { "零", "一", "二", "三", "四", "五", "六", "七", "八", "九" },
        word = true,
        cyclic = true,
      }),

      augend.constant.new({
        elements = { "&&", "||" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "and", "or" },
        word = true,
        cyclic = true,
      }),

      augend.semver.alias.semver, -- Semantic version                                 ; e.g. `0.3.0`, `1.22.1`, `3.9.1`, ...
    }

    local default_group_with = function(group)
      return vim.list_extend(default_group, group)
    end

    require("dial.config").augends:register_group({
      default = default_group,
      java = default_group_with({
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
      }),
    })

    require("settings.fn").keymap.set({
      {
        desc = "Increment/Dail up",
        cmd = require("dial.map").inc_normal(),
        keys = { "n", "<C-a>" },
        mode = require("commander").mode.SET,
      },
      {
        desc = "Decrement/Dail down",
        cmd = require("dial.map").dec_normal(),
        keys = { "n", "<C-x>" },
        mode = require("commander").mode.SET,
      },

      {
        desc = "Increment/Dail up",
        cmd = require("dial.map").inc_visual(),
        keys = { "v", "<C-a>" },
        mode = require("commander").mode.SET,
      },
      {
        desc = "Decrement/Dail down",
        cmd = require("dial.map").dec_visual(),
        keys = { "v", "<C-x>" },
        mode = require("commander").mode.SET,
      },

      {
        desc = "Increment/Dail up",
        cmd = require("dial.map").inc_gvisual(),
        keys = { "v", "g<C-a>" },
        mode = require("commander").mode.SET,
      },
      {
        desc = "Decrement/Dail down",
        cmd = require("dial.map").dec_gvisual(),
        keys = { "v", "g<C-x>" },
        mode = require("commander").mode.SET,
      },
    })
  end,
}
