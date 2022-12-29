# Nord color theme for dircolors
zinit light-mode for \
    atclone"dircolors -b src/dir_colors > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}' \
  arcticicestudio/nord-dircolors

# zinit wait lucid for \
#     atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
#   zdharma-continuum/fast-syntax-highlighting
zinit light-mode for \
  wait lucid atload'_zsh_autosuggest_start' \
  zsh-users/zsh-syntax-highlighting
