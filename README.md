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

Be sure to read the `README.md` in each directory
and understand what it does
before you `stow` them.

### Sensitive Information

Sensitive information are compressed by tar and encrypted with gpg.

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

### zsh

#### install `zinit`
[`zinit`](https://github.com/zdharma-continuum/zinit#customizing-paths)
is the plug in manager
I use for zsh.

In order for
zsh configuration work properly,
we have to first install `zinit`:
```shell
$ ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
$ mkdir -p "$(dirname $ZINIT_HOME)"
$ git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
```

Then,
close and start the terminal.
All plugins will be installed properly.

### Neovim

You need to have
[neovim editor](https://neovim.io) (>= 0.6.1)
installed on your machine.

- Telescope can be used to view image
if `catimg` is installed locally on the machine.

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
