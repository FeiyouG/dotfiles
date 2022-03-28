# .zprofile is sourced by all login shells

# ---- PATH ----
# PATH set in .zshenv may be overritten by /etc/porfile
PATH="/usr/local/bin:$PATH"                                         # Path to all installed executables
PATH="$HOME/bin:$PATH"                                              # Add custom shell scripts to path
PATH="$HOME/Applications/CMake.app/Contents/bin:$PATH"              # Path to cMake App (needed by ccls)
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"                   # Path to homebrew executable
export PATH
