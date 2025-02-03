# vim:ft=zsh

# MARK: MSIC
export LANG=en_US.UTF-8
export EDITOR="nvim"                                              # Default editor
export VISUAL="nvim"                                              # Default editor

# MARK: UTILITIES
alias rm="rm -i"                                                  # Confirmation on remving
alias ls="ls --color"                                             # Enable color for ls
alias config_zsh="nvim $XDG_CONFIG_HOME/zsh/.zshrc"               # Fast access to configuration file

# MARK: DOTFILES
export DOTFILES="$HOME/.dotfiles"

# MARK: zk
export ZK_NOTEBOOK_DIR="$HOME/Vault/ZK"                           # Env for vault home
export ZK_EDITOR="nvim"                                           # Default editor for zk
alias config_vault="nvim $ZK_NOTEBOOK_DIR/.zk/config.toml"        # Fast access to valut configuration file
alias config_zk="nvim $ZK_NOTEBOOK_DIR/.zk/config.toml"           # Fast access to valut configuration file

# MARK: LESS
export LESSKEY="$XDG_CONFIG_HOME/less/keys"                       # Conform to XDG Base Directory (configuration file)
export LESSHISTFILE="$XDG_STATE_HOME/less/history"                # Conform to XDG Base Directory (history file)

# MARK: WGET
# export WGETRC="$XDG_CONFIG_HOME/wgetrc"                           # Conform to XDG Base Directory (configuration file)
# alias wget="wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"         # Conform to XDG Base Directory (history file)

# MARK: Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rust/Rustup"
export CARGO_HOME="$XDG_DATA_HOME/rust/cargo"
export PATH="$CARGO_HOME/bin:$PATH"
if which rustc > /dev/null 2>&1; then
  zsh-defer source "$CARGO_HOME/env"
fi

# MARK: Python
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"              # Conform to XDG Base Directory (configuration file)

# MARK: python virtualenvs
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"                   # Conform to XDG Base Directory (data)
export VIRTUALENVWRAPPER_WRAPPER="$HOMEBREW_PREFIX/bin/virtualenvwrapper.sh"
if [ -f $VIRTUALENVWRAPPER_WRAPPER ]; then                       # Setup virtualevnwrappers
  export VIRTUALENVWRAPPER_PYTHON="$HOMEBREW_PREFIX/bin/python3.11"
  zsh-defer source $VIRTUALENVWRAPPER_WRAPPER
fi

# MARK: Java
export M2_HOME="$XDG_DATA_HOME/maven2"
if which jenv > /dev/null 2>&1; then
  export JENV_ROOT="$XDG_DATA_HOME/java/jenv"                       # Conform to XDG Base Directory (data)
  zsh-defer eval "$(jenv init -)"
fi

# MARK: GO
export GOPATH="$XDG_DATA_HOME/go"           # Conform to XDG Base Directory
export GOBIN="$XDG_DATA_HOME/go/bin"        # Conform to XDG Base Directory
export PATH="$XDG_DATA_HOME/go/bin:$PATH"   # Path to go executables

# MARK: Ocaml and Opam
export OPAMROOT="$XDG_DATA_HOME/opam"       # Conform to XDG Base Directory
[[ ! -r /Users/feiyouguo/.local/share/opam/opam-init/init.zsh ]] || source /Users/feiyouguo/.local/share/opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# MARK: nodejs and npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"         # Conform to XDG Base Directory (configuration file)
export npm_config_cache="$XDG_CACHE_HOME/npm"                     # Conform to XDG Base Directory (cache)
export npm_config_prefix=$XDG_DATA_HOME/npm                       # Conform to XDG Base Directory (data)
export PATH=$PATH:$XDG_DATA_HOME/npm/bin                          # Add global npm execuatble to PATH

# MARK: Custom
export VAULT="$HOME/vault"
export FIN_HOME="$VAULT/Fin"
