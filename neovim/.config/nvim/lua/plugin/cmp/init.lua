return {
  -- nvim-cmp ecosystem
  require("plugin/cmp/nvim-cmp"),
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'petertriho/cmp-git' },
  -- { 'rcarriga/cmp-dap' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },

  -- Additional completion features
  require("plugin/cmp/nvim-ts-autotag"),
  require("plugin/cmp/nvim-autopairs"),
}
