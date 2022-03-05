export PATH="$HOME/bin:/usr/local/bin":"/Applications/CMake.app/Contents/bin":"$PATH"

# ---- Import all aliases and env variables from dotfiles repo ----
if [ -f $HOME/.aliases ]
then
  source $HOME/.aliases
fi

# ---- Import all aliases and env on local machine ----
if [ -f $HOME/.aliases_local ]
then
  source $HOME/.aliases_lcoal
fi
