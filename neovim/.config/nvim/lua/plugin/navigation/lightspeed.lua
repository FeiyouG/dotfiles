return {
  'ggandor/lightspeed.nvim',

  defer = function()
    vim.cmd [[
        let g:lightspeed_last_motion = ''
        augroup lightspeed_last_motion
        autocmd!
        autocmd User LightspeedSxEnter let g:lightspeed_last_motion = 'sx'
        autocmd User LightspeedFtEnter let g:lightspeed_last_motion = 'ft'
        augroup end
        map <expr> ; g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"
        map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"
    ]]
  end
}
