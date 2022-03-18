# Path to all installed executables
PATH="/usr/local/bin:$PATH"

# Add custom shell scripts to path
PATH="$HOME/bin:$PATH"

# Path to cMak.app, needed for ccls language server to work. (may not be neccesary>)
PATH="/Applications/CMake.app/Contents/bin:$PATH"

# Use GNU-util instead
PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"

export PATH


# ---- Import all aliases and env on local machine ----
[ -f $HOME/.bashrc.local ] && source $HOME/.bashrc.local

# ---- Import extra aliases and env variables from dotfiles repo ----
export SHELLCONFIG="$HOME/.config/shell"
[ -f $SHELLCONFIG/.rc.general ] && source $SHELLCONFIG/.rc.general

# Bash specific fzf settings
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

