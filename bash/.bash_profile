# PATH set in .zshenv may be overritten by /etc/porfile
PATH="/usr/local/bin:$PATH"                                         # Path to all installed executables
PATH="$HOME/.local/bin:$PATH"                                       # Add custom shell scripts to path
export PATH

source $HOME/.bashrc

