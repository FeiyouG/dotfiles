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

Make sure to read
**REDME.md file inside each directory**
before you `stow` them
so that you understand
how to set things up properly.

### A Note to myself

To properly decrypt
contents in `encryt/`,
I have to make sure
private gpg keys
are securely transferred to the machine.

Next, I need to clone
without checking out,
setup git smudge and clean,
and then check out the content:
```shell
git clone --no-checkout git@github.com:Exquisitian/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles
git config filter.encrypt.require true
git config filter.encrypt.clean "gpg -er feiyouguo@gmail.com"
git config filter.encrypt.smudge "gpg -d"
git checkout --
```

## Dependencies

### General

All tools below can be installed
with `homebrew` or `linuxbrew`:

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
  - If you are on macOS
    and installed GNU coreutils with `homebrew`,
    then make sure to replace macOS default utils
    with GNU coreutils by adding
    ```
    export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
    ```
    to your `.zshrc.local` or `.bashrc.local` file
- fzf
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
$ git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME
```

Then,
close and start the terminal.
All plugins will be automatically downloaded and sourced.

### Neovim

You need to have
[neovim editor](https://neovim.io) (>= 0.6.1)
installed on your machine.

The plugin manager `packer`
is automatically installed
on your first start up.
Restart neovim
And run `:PackerSync`
to install and compile
all plugins.
Then you are good to go.

### TMUX

#### Install tpm

[`tpm`](https://github.com/tmux-plugins/tpm)
is the plug in manager
I use for `tmux`.

In order for
tmux configuration work properly,
we have to first install `tpm`:
```shell
$ TMP_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/tmux/plugins/tpm"
$ mkdir -p "$(dirname $TMP_HOME)"
$ git clone https://github.com/tmux-plugins/tpm $TMP_HOME
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
