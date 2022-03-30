# Feiyou's dotfiles

The structure of this repository
is inspired by [Alex Pearce](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
and [Abdullah Khabir](https://abdullah.today/encrypted-dotfiles/).

## Usage

Clone this repository into your `$HOME` folder.


```shell
$ git clone git@github.com:Exquisitian/dotfiles.git $HOME/.dotfiles
$ cd $HOME/.dotfiles
$ stow zsh neovim git # plus whatever else you'd like
```

You will notice
every file inside `encrypt/`
is gibberish.
It is because
they are all encrypted
with my gpg key.

### A Note to myself

To properly decrypt
contents in `encryt/`,
I need to clone
without chekcing out,
setup git smudge and clean,
and then check out the content:
```shell
git clone --no-checkout git@github.com:Exquisitian/dotfiles.git $HOME/.dotfiles
git config filter.encrypt.require true
git config filter.encrypt.clean "gpg -er feiyouguo@gmail.com"
git config filter.encrypt.smudge "gpg -d"
git checkout --
```

## Dependencies

### General

- stow
  - Helps to create symbolic links
    from this directory to `$HOME`;
    can use `ln` instead
- gpg
  - Essential to encrypt and decrypt
    sensitive information in `encrypt/`
    (the folder is not under version control)
- GNU coreutils
  - Essential for some shell scripts
    to run properly in `bin/`
- FZF
  - `fzf` is used for both
    zsh completion and
    neovim telescope (file and string search)

### zsh

#### install `zinit`
[`zinit`](https://github.com/zdharma-continuum/zinit#customizing-paths)
is the plug in manager
I use for zsh.

In order for
zsh configuration to work properly,
`zinit` needs to be installed:
```shell
$ ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
$ mkdir -p "$(dirname $ZINIT_HOME)"
$ git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
```

Then,
close and start the terminal.
All plugins will be automatically downloaded and sourced.

### Neovim

You need to have
[neovim editor](https://neovim.io) (>= 0.6.1)
installed on your machine.

### TMUX

#### Install tpm

[`tpm`](https://github.com/tmux-plugins/tpm)
is the plug in manager
I use for `tmux`.

In order for
tmux configuration work properly,
we have to first install `tpm`:
```shell
$ git clone https://github.com/tmux-plugins/tpm $XDG_DATA_HOM/tmux/plugin/tpm
```

Then,
inside a **new** tmux session
(making sure all previous sessions were closed)
and press `prefix` + `I`
to install all plugins properly.

#### tmux default terminal

Use `tmux-256color`
for tmux default terminal
for true color and italic support.


## License
[MIT](https://opensource.org/licenses/MIT).
