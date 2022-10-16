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
  homebrew/brew
