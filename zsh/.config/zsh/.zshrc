# .zshrc is sourced for every interactive zsh shell
# All env vars that subshell and external commands don't need go here

# MAKR: Install and configure zinit
# Configure zinit paths
export ZINIT_HOME="$XDG_DATA_HOME/zsh/zinit/plugins/zinit.git"

declare -A ZINIT # initial Zinit's hash definition
ZINIT[BIN_DIR]="$XDG_DATA_HOME/zsh/zinit/plugins/zinit.git"
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zsh/zinit"
ZINIT[PLUGINS_DIR]="$XDG_DATA_HOME/zsh/zinit/plugins"
ZINIT[COMPLETIONS_DIR]="$XDG_DATA_HOME/zsh/zinit/completions"
ZINIT[SNIPPETS_DIR]="$XDG_DATA_HOME/zsh/zinit/snippets"
ZINIT[ZCOMPDUMP_PATH]="$(safe_path $XDG_CACHE_HOME/zsh)/zcompdump-$ZSH_VERSION"
ZINIT[COMPINIT_OPTS]="-d '$(safe_path $XDG_CACHE_HOME/zsh)/zcompdum-$ZSH_VERSION'"
ZINIT[MUTE_WARNINGS]=0
ZINIT[OPTIMIZE_OUT_DISK_ACCESS]=0

# Install (if not exist) zinit
if [[ ! -d $ZINIT_HOME ]]; then
    print -P "%F{33} %F{220} Installing Plugin Manager zinit%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} Installation has failed.%f%b"
fi

# Source zinit
source "$ZINIT_HOME/zinit.zsh"

# Install zinit extensions
zinit light zdharma-continuum/zinit-annex-bin-gem-node

# MARK: Source all configuration files
setopt extendedglob  #  Use negation (~/^) in file pattern
setopt nullglob      #  Ignore error if no match is found

for file in $ZDOTDIR/src/**/*.zsh; do
  source "$file"
done

unsetopt extendedglob
unsetopt nullglob

# Source local configurations
source $HOME/.zshrc.local

bindkey -e                     # Resotre default keybidning
