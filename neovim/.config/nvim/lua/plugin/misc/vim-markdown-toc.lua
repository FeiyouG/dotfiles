return {
  'mzlogin/vim-markdown-toc',

  ft = { "markdown" },

  config = function()
    vim.cmd "let g:vmt_fence_text='TOC'"
    vim.cmd "let g:vmt_fence_closing_text='/TOC'"
    vim.cmd "let g:vmt_list_item_char = '-'"
    vim.cmd "let g:vmt_include_headings_before = 0"
  end,

  defer = function()
    local has_command_center, command_center = pcall(require, 'command_center')
    if not has_command_center then return end

    command_center.add({
      {
        description = "Generate table of contents (GFM)",
        cmd = "<CMD>GenTocGFM<CR>",
      }
    })
  end
}
