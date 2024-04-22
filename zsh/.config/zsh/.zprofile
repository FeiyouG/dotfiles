# .zprofile is sourced by all login shells

# ---- PATH ----
# PATH set in .zshenv may be overritten by /etc/porfile
PATH="/usr/local/bin:$PATH"                       # Path to all installed executables
PATH="$XDG_DATA_HOME/bin:$PATH"                   # Add custom shell scripts to path

export PATH

# source .zprofile on $HOME, if exists
if [[ -f $HOME/.zprofile ]]; then
  source $HOME/.zprofile
fi
