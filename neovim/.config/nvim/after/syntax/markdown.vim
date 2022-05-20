" ---- MARK: Conceal support ----
" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter
  \ start="\[\[" end="\]\]"
  \ contains=markdownUrl
  \ keepend
  \ oneline
  \ concealends

" markdownLinkText is copied from runtime files with 'concealends' appended
syn region markdownLinkText matchgroup=markdownLinkTextDelimiter
  \ start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@="
  \ nextgroup=markdownLink,markdownId skipwhite
  \ contains=@markdownInline,markdownLineStart
  \ concealends

" syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart concealends

" markdownLink is copied from runtime files with 'conceal' appended
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained conceal



" Todo list
if exists("b:current_syntax")
  finish
endif

" Custom conceal
syntax match todoCheckBox '\v(\s+)?-\s\[\s\]'hs=e-4 conceal cchar=
syntax match todoCheckBox '\v(\s+)?-\s\[X\]'hs=e-4 conceal cchar=

let b:current_syntax = "todo"

hi def link todoCheckbox Todo
hi Conceal guibg=NONE

setlocal cole=1
setlocal conceallevel=2
