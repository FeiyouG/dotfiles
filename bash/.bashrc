# XDG Directory specification (all in default values)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Path to all installed executables
PATH="/usr/local/bin:$PATH"

# Add custom shell scripts to path
PATH="$HOME/bin:$PATH"

# Path to cMak.app, needed for ccls language server to work. (may not be neccesary>)
PATH="/Applications/CMake.app/Contents/bin:$PATH"

export PATH

# ---- Import all aliases and env on local machine ----
[ -f $HOME/.bashrc.local ] && source $HOME/.bashrc.local

# Bash specific fzf settings
[ -f $XDG_CONFIG_HOME/fzf/fzf.bash ] && source $XDG_CONFIG_HOME/fzf/fzf.bash

# ---- Import extra aliases and env variables ----
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
[ -f $ZDOTDIR/.rc.general ] && source $ZDOTDIR/.rc.general
