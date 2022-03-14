## `.helper/`

You shouldn't need to manually `stow`
anything from this directory.

This directory contains some common files
required by multiple directories in `.dotfiles/`.
Think of it as a *private helper method*
that you'd never need to call.

For example, the directory `additional/shell`
contains files that
both `bash` and `zsh` need to source.
In this way,
we don't end up with duplicate files in
different directories in
`.dotfiles/bash` and `.dotfiles/zsh`.
You can simply
```shell
cd .dotfiles/; stow zsh
```
to get all the files needed for `zsh` to work.

