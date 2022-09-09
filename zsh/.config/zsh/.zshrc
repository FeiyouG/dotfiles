# .zshrc is sourced for every interactive zsh shell
# All env vars that subshell and external commands don't need go here

local config_files=(
  $ZDOTDIR/src/general.zsh     # Setup aliases and env vars
  $HOME/.zshrc.local           # Local overwrites of aliases and env vars

  $ZDOTDIR/src/zinit.zsh       # Setup the plugin manager; must be first
  $ZDOTDIR/src/theme.zsh       # Setup theme
t $ZDOTDIR/src/spaceship.zsh   # Setup zsh prompt with spaceship plugin
  $ZDOTDIR/src/completion.zsh  # Setup zsh completion with multiple plugins
  $ZDOTDIR/src/highlights.zsh  # Setup syntax highlighting; must be the last
)

for file in $config_files[@]; do
  if [[ -a "$file" ]]; then
    source "$file"
  fi
done

bindkey -e                     # Resotre default keybidning
