autoload -U compinit
compinit -d "$(safe_path $XDG_CACHE_HOME/zsh)/zcompdum-$ZSH_VERSION"  # Conform to XDG Base Directory (cache file)
zinit ice blockf
zinit light zsh-users/zsh-completions                                 # zsh completion
zinit light zsh-users/zsh-autosuggestions                             # Autosuggestion based on history
zinit light Aloxaf/fzf-tab                                            # Completion with fzf interface
