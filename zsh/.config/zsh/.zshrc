# .zshrc is sourced for every interactive zsh shell
# All vars that subshell and external commands don't need go here

# ---- Completion ----
# autoload -U compinit; cominit
# compinit -d "$(safe_path $XDG_CACHE_HOME/zsh)/zcomdum-$ZSH_VERSION" # Conform to XDG directory specification (cache file)


# ---- Import all aliases and env on local machine ----
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

# Zsh specific fzf settings
[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh

# ---- Import extra aliases and env variables from dotfiles repo ----
[ -f $ZDOTDIR/.rc.general ] && source $ZDOTDIR/.rc.general


# ---- ZINIT ----
source "$ZINIT_HOME/zinit.zsh"
# Uncomment the following line if source is below compinit
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice atclone"dircolors -b src/dir_colors > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light arcticicestudio/nord-dircolors


zinit ice blockf
zinit light zsh-users/zsh-completions

zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-syntax-highlighting                        # This must be sourced at the end of the file

