# Install ...
# - fzf binary
# - fzf completion and keybinding scripts
# - fzf interface for shell completion
zinit light-mode wait lucid for \
    atload'
      export FZF_DEFAULT_OPTS="
        --color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
        --color=fg+:#eceff4,bg+:#2e3440,hl+:#88c0d0
        --color=info:#eacb8a,prompt:#81a1c1,pointer:#b988b0
        --color=marker:#81a1c1,spinner:#e5e9f0,header:#b988b0"
      export FZF_DEFAULT_COMMAND="fd -t f"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMA
    ' from"gh-r" sbin"fzf" \
  junegunn/fzf \
  https://github.com/junegunn/fzf/raw/master/shell/{'completion','key-bindings'}.zsh \
  Aloxaf/fzf-tab



