return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("ufo").setup({
        open_fold_hl_timeout = 150,
        close_fold_kinds_for_ft = { "imports" },
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
        preview = {
          win_config = {
            border = settings.icons.editor.border.rounded,
            winhighlight = settings.icons.editor.border.winhighlight,
            winblend = settings.icons.editor.border.winblend,
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
      --	vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      --	vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      --	vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      --	vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      --	vim.keymap.set("n", "K", function()
      --		local winid = require("ufo").peekFoldedLinesUnderCursor()
      --		if not winid then
      --			vim.lsp.buf.hover()
      --		end
      --	end)

      -- MARK: vim settings
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    commander = {
      {
        cmd = function() require("ufo").openAllFolds() end,
        desc = "Open all folds in current buffer"
      },
      {
        cmd = function() require("ufo").closeAllFolds() end,
        desc = "close all folds in current buffer"
      },
    }
  },

}
