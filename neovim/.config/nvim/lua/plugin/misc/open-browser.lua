return {
  "tyru/open-browser.vim",

  commands = function()
    return {
      {
        desc = "Smart search link/word under cursor",
        cmd = "<Plug>(openbrowser-smart-search)",
        keys = {
          { "n", "gx", Utils.keymap.remap },
          { "v", "gx", Utils.keymap.remap },
        }
      }
    }
  end
}
