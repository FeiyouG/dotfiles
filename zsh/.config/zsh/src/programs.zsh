# MARK: FZF
# - fzf, fd, rg and bat binaries come from Homebrew (see Brewfile)
# - fzf keybindings/completion come from the installed fzf (`fzf --zsh`)
# - fzf-tab (fzf interface for shell completion) comes from zinit
export FZF_DEFAULT_OPTS="
  --color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
  --color=fg+:#eceff4,bg+:#2e3440,hl+:#88c0d0
  --color=info:#eacb8a,prompt:#81a1c1,pointer:#b988b0
  --color=marker:#81a1c1,spinner:#e5e9f0,header:#b988b0"
export FZF_DEFAULT_COMMAND="fd -t f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"

# fzf-tab ignores FZF_DEFAULT_OPTS (and its nord colors) unless told otherwise
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Load fzf keybindings before fzf-tab so fzf-tab owns <Tab>
zinit light-mode wait lucid for \
    atinit'
      (( $+commands[fzf] )) && eval "$(fzf --zsh)"
      bindkey -s "^p" "~/.config/tmux/bin/sessionizer\n"
    ' \
  Aloxaf/fzf-tab
