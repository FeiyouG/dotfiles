# .zshenv is sourced by every new zsh shell
# Vars that needed by external commands go here

# ---- XDG Base Direcotry ----
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"



export ZDOTDIR="$XDG_CONFIG_HOME/zsh"                               # Conform to XDG Base Directory (configuration file)
