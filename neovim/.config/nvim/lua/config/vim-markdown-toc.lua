local command_center = require("command_center")
local noremap = { noremap = true }

command_center.add({
  {
    description = "Generate table of contents (GFM)",
    command = "GenTocGFM",
  }
})

vim.cmd "let g:vmt_fence_text='TOC'"
vim.cmd "let g:vmt_fence_closing_text='/TOC'"
vim.cmd "let g:vmt_list_item_char = '-'"
vim.cmd "let g:vmt_include_headings_before = 0"

