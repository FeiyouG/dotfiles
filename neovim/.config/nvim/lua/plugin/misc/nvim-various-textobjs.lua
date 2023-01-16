return {
  "chrisgrieser/nvim-various-textobjs",

  config = function()
    require("various-textobjs").setup({
      lookForwardLines = 5, -- Set to 0 to only look in the current line.
      useDefaultKeymaps = true, -- Use suggested keymaps (see README).
    })

    vim.keymap.set("n", "gx", function()
      require("various-textobjs").url() -- select URL
      local foundURL = vim.fn.mode():find("v") -- only switches to visual mode if found
      local url
      if foundURL then
        vim.cmd.normal({ '"zy', bang = true }) -- retrieve URL with "z as intermediary
        url = vim.fn.getreg("z")

        local opener
        if vim.fn.has("macunix") then
          opener = "open"
        elseif vim.fn.has("unix") then
          opener = "xdg-open"
        elseif vim.fn.has("win64") or fn.has("win32") then
          opener = "start"
        end
        os.execute(opener .. "'" .. url .. "'")
      else
        -- if not found in proximity, search whole buffer via urlview.nvim instead
        vim.cmd.UrlView("buffer")
      end
    end, { desc = "Smart URL Opener" })
  end,
}
