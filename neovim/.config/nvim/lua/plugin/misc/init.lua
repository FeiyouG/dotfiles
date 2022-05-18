return {
  require("plugin/misc/comment"),
  require("plugin/misc/markdown-preview"),
  require("plugin/misc/vim-markdown-toc"),
  { 'moll/vim-bbye' },
  { 'tpope/vim-repeat' },
  { 'preservim/vim-markdown', requires = { 'godlygeek/tabular' } },
  { 'dhruvasagar/vim-table-mode' }
}
