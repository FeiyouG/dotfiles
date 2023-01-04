zinit light-mode wait lucid for \
    blockf \
    atload"export ZSH_AUTOSUGGEST_MANUAL_REBIND=''" \
  zsh-users/zsh-autosuggestions \
    atload"zicompinit; zicdreplay" \
    blockf \
  zsh-users/zsh-completions \
    wait"1b" lucid lucid atload"
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
    " \
  zsh-users/zsh-history-substring-search



