# MARK: History file configuration
export HISTFILE="$XDG_STATE_HOME/zsh/history"  #  Conform to XDG Base Directory (history file)
export HISTSIZE=20000                          #  Max events for internal history
export SAVEHIST=10000                          #  Max events in history file

# MARK: History command configuration
setopt extended_history                        #  record timestamp of command in HISTFILE
setopt inc_append_history                      #  Write to the history file immediately, not when the shell exits.
setopt hist_verify                             #  show command with history expansion to user before running it
setopt share_history                           #  share history between all sessions

setopt hist_expire_dups_first                  #  delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups                        #  ignore duplicated commands history list
setopt hist_ignore_all_dups                    #  delete old recorded entry if new entry is a duplicate.
setopt hist_find_no_dups                       #  Do not display a line previously found.
setopt hist_save_no_dups                       #  Don't write duplicate entries in the history file.

setopt hist_ignore_space                       #  ignore commands that start with space
setopt hist_reduce_blanks                      # remove superfluous blanks before recording entry.
