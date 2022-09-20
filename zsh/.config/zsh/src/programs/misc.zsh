zinit wait lucid from"gh-r" for \
    sbin'**/fd -> fd' \
  @sharkdp/fd \
    sbin'**/rg -> rg' \
  @BurntSushi/ripgrep \
    sbin'**/bat -> bat' \
  @sharkdp/bat \

zinit wait lucid as"completion" for \
  OMZP::fd/_fd \
  OMZP::ripgrep/_ripgrep \

