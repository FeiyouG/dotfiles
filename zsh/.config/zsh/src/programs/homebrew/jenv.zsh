if which jenv > /dev/null; then
  export JENV_ROOT="$XDG_DATA_HOME/java/jenv"                       # Conform to XDG Base Directory (data)
  eval "$(jenv init -)"
fi

# To add a java version: jenv add /Library/java/JavaVirtualMachines/jdk-*.jdk/Contents/Home
