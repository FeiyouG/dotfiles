local style = require("settings.style")
return {
  "kevinhwang91/nvim-ufo",

  dependencies = { "kevinhwang91/promise-async" },

  config = function()
    require("ufo").setup({
      open_fold_hl_timeout = 150,

      close_fold_kinds = { "imports" },

      ---@diagnostic disable-next-line: unused-local
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,

      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}

        local fold_cnt = endLnum - lnum
        local suffix = (" ...(%d line" .. (fold_cnt > 1 and "s" or "") .. ")"):format(endLnum - lnum)

        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "Folded" })
        return newVirtText
      end,

      enable_get_fold_virt_text = false,

      preview = {
        win_config = {
          border = style.border.rounded,
          winhighlight = style.border.winhighlight,
          winblend = style.border.winblend,
          maxheight = 20,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          scrollE = "<C-e>",
          scrollY = "<C-y>",
          close = "q",
          switch = "<Tab>",
          trace = "<CR>",
        },
      },
    })

    -- MARK: Override keymaps
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end)

    -- MARK: vim settings
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Setup sign column for folding
    -- TODO: Use statuscolumn once nvim 0.9 is released
    -- vim.o.foldcolumn = "0"
    -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  end,
}
