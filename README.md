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

Sensitive information are encrypted by tar.

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

### Neovim

You need to have
[neovim editor](https://neovim.io) (>= 0.6.1)
installed on your machine.

## License
[MIT](https://opensource.org/licenses/MIT).
