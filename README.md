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

### Sensitive Information

Sensitive information are encrypted by tar.

## Dependencies

### General

- git
- stow

### Neovim

You need to have
[neovim editor](https://neovim.io) (>= 0.6.1)
installed on your machine.

## License
[MIT](https://opensource.org/licenses/MIT).
