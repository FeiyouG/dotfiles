# XDG Directory specification (all in default values)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Hardcode to make zsh conform to XDG direcotry specificiaion
# Source configurations in $XDG_CONFIG_HOME
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Save zsh history in XDG _STATE_HOME
export HISTFILE="$XDG_STATE_HOME/zsh/history"
