zi light-mode wait lucid for \
    as'null' \
    atclone'%atpull' \
    atpull'
         ./bin/brew update --preinstall \
      && ln -sf $PWD/completions/zsh/_brew $ZINIT[COMPLETIONS_DIR]' \
    depth'3' \
    nocompletions \
    sbin'bin/brew' \
    eval"./bin/brew shellenv" \
    atload"source_zsh $0" \
  homebrew/brew

# MARK: Homebrew
export HOMEBREW_NO_AUTO_UPDATE=true

# MARK: GNUPG
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg/"  # Conform to XDG Base Directory (all files)

# MARK: GO
export GOPATH="$XDG_DATA_HOME/go"           # Conform to XDG Base Directory
export GOBIN="$XDG_DATA_HOME/go/bin"        # Conform to XDG Base Directory
export PATH="$XDG_DATA_HOME/go/bin:$PATH"   # Path to go executables


# MARK: Ruby
# if brew ls --versions ruby > /dev/null; then
#   PATH="$HOMEBREW_PREFIX/Cellar/ruby/bin:$PATH"             # Path to ruby executabe
#   PATH="`gem environment gemdir`/bin:$PATH"                 # Path to ruby gem
#   export PATH
#
#   export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/ruby/bundle  # Conform to XDG Base Directory (configuration file)
#   export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/ruby/bundle    # Conform to XDG Base Directory (cache)
#   export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle         # Conform to XDG Base Directory (data)
#   export GEM_HOME="$XDG_DATA_HOME"/ruby/gem                 # Conform to XDG Base Directory (data)
#   export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/ruby/gem          # Conform to XDG Base Directory (cache)
# fi


