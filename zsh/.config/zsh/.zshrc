# .zshrc is sourced for every interactive zsh shell
# All vars that subshell and external commands don't need go here

# ---- Import all aliases and env on local machine ----
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

# Zsh specific fzf settings
[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh

# ---- Import extra aliases and env variables from dotfiles repo ----
[ -f $ZDOTDIR/.rc.general ] && source $ZDOTDIR/.rc.general


bindkey -e                                                          # Resotre default keybidning

# ---- ZINIT ----

# -- Config ZINIT
export ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
declare -A ZINIT
ZINIT[BIN_DIR]="$XDG_DATA_HOME/zinit/zinit.git"
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit/"
ZINIT[PLUGINS_DIR]="$XDG_DATA_HOME/zinit/plugins"
ZINIT[COMPLETIONS_DIR]="$XDG_DATA_HOME/zinit/completions"
ZINIT[SNIPPETS_DIR]="$XDG_DATA_HOME/zinit/snippets"
ZINIT[ZCOMPDUMP_PATH]="$(safe_path $XDG_CACHE_HOME/zsh)/zcompdump-$ZSH_VERSION"

source "$ZINIT_HOME/zinit.zsh"

# -- ZSH PROMPT
# zinit snippet "https://github.com/arcticicestudio/igloo/blob/master/snowblocks/zsh/lib/themes/igloo.zsh"
source $XDG_CONFIG_HOME/zsh//config/prompt.zsh
ZSH_PROMPT_ALWAYS_SHOW_USER=${IGLOO_ZSH_PROMPT_THEME_ALWAYS_SHOW_USER:-false}

zinit snippet "https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh"
# GIT_PS1_SHOWCOLORHINTS=1                                              # Show color
GIT_PS1_SHOWUPSTREAM="auto verbose"

# -- ZSH COMPLETION
autoload -U compinit
compinit -d "$(safe_path $XDG_CACHE_HOME/zsh)/zcompdum-$ZSH_VERSION"  # Conform to XDG Base Directory (cache file)
zinit ice blockf
zinit light zsh-users/zsh-completions                                 # zsh completion

zinit light zsh-users/zsh-autosuggestions                             # Autosuggestion based on history
zinit light Aloxaf/fzf-tab                                            # Completion with fzf interface

# -- SYNTAX HIGHLIGHTING & COLOR
zinit ice atclone"dircolors -b src/dir_colors > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
zinit light arcticicestudio/nord-dircolors                            # Nord color theme for dircolors
zinit light zsh-users/zsh-syntax-highlighting                         # This must be sourced at the end of the file

