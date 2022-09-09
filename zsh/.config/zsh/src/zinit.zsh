# Configure and install ZINIT
export ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
declare -A ZINIT
ZINIT[BIN_DIR]="$XDG_DATA_HOME/zinit/zinit.git"
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit/"
ZINIT[PLUGINS_DIR]="$XDG_DATA_HOME/zinit/plugins"
ZINIT[COMPLETIONS_DIR]="$XDG_DATA_HOME/zinit/completions"
ZINIT[SNIPPETS_DIR]="$XDG_DATA_HOME/zinit/snippets"
ZINIT[ZCOMPDUMP_PATH]="$(safe_path $XDG_CACHE_HOME/zsh)/zcompdump-$ZSH_VERSION"

# Init ZINIT
source "$ZINIT_HOME/zinit.zsh"

