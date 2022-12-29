# .zshrc is sourced for every interactive zsh shell
# All env vars that subshell and external commands don't need go here
zmodload zsh/zprof

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
zinit light NICHOLAS85/z-a-eval
zinit light romkatv/zsh-defer

# MARK: Source all configuration files

# note: checkout global quantifiers and recursive globbing (https://linux.die.net/man/1/zshexpn)
# N - sets the NULL_GLOB option for the pattern (ignore error if no match)
# on - specifies the files are sorted by name (ascending)
config_dirs=( $ZDOTDIR/src/***/(N) )
for dir in $config_dirs; do
  if [[ ! -f "${dir}init.zsh" ]]; then
    files=( ${dir}*.zsh(N) )
    for f in $files; do
      source $f
    done
  else
    source ${dir}init.zsh
  fi
done
# config_files=( $ZDOTDIR/src/*.zsh(N) )        # source all .zsh files
# config_files+=( $ZDOTDIR/src/***/init.zsh(N) ) # surce init.zsh in dirs; extra * for symbolic linked dirs
# config_files+=( $HOME/.zshrc.local(N) )       # Source local configurations
# for file in $config_files; do
#   source $file
# done

bindkey -e                     # Resotre default keybidning
# zprof
