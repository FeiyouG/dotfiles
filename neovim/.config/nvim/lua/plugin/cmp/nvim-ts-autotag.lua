return {
  'windwp/nvim-ts-autotag',

  config = function()
    require('nvim-ts-autotag').setup {
      filetypes = {
        'html',
        'xml',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'svelte',
        'vue',
        'rescript',
      },
    }
  end
}
