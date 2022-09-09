# SYNTAX HIGHLIGHTING & COLOR
zinit ice atclone"dircolors -b src/dir_colors > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
zinit light arcticicestudio/nord-dircolors                            # Nord color theme for dircolors
