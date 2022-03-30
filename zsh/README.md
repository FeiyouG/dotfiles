## zsh and bash

<!-- TOC GFM -->

- [zsh and bash](#zsh-and-bash)
  - [zsh](#zsh)
    - [Plugin Manager](#plugin-manager)
    - [Content](#content)
      - [.zshenv](#zshenv)
      - [.zprofile/.zlogin](#zprofilezlogin)
      - [.zshrc](#zshrc)
      - [.rc.general](#rcgeneral)
      - [.zsh.local](#zshlocal)
  - [bash](#bash)

<!-- /TOC -->



### zsh

#### Plugin Manager
[`zinit`](https://github.com/zdharma-continuum/zinit#customizing-paths)
is the plug in manager
I use for zsh.

In order for
zsh configuration to work properly,
`zinit` needs to be installed
into the correct directory
(according to `$XDG_XXX_HOME` specification):
```shell
$ ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
$ mkdir -p "$(dirname $ZINIT_HOME)"
$ git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME
```

Then,
close and start the terminal.
All plugins will be automatically downloaded and sourced.


#### Content
The order of which
source file are loaded
is illustrated below:
```
.zshenv -> .zprofile -> .zshrc -> .zlogin -> .zlogout
```

##### .zshenv
`.zshenv` is sourced
by all every new zsh shell.
Only environmental variables
that are needed by external programs
are stored in `.zshenv`.

##### .zprofile/.zlogin
`.zprofile` is the same as `.zlogin`.
except `.zprofile` is sourced before `.zshrc`
Both files are sourced
by all login shells.
and `.zlogin` is after.

It's a good practice to set up
either `.zprofile` or `.zlogin`,
but not both.
This repository uses `.zprofile`.

##### .zshrc
`.zshrc` is sourced
by every interactive shells.
Thus,
all environmental variables
that subshell and external commands
don't necessarily need can go here.

`.zshrc` sources `$HOME/.zshrc.loca`
first for some local settings.
Then it sources the
completion file for `fzf`,
if it exists.
Finally,
it sources `$XDG_CONFIG_HOME/zsh/config/.rc.general`.

##### .rc.general

This file contains
settings, variables, alias
that are useful to both
`.bashrc` and `.zshrc`.

`.rc.private`, `.rc.macos`, `.rc.linux`,
`.rc.win32`, and `.rc.win64`
are some other source files
that are shared between `.bashrc` and `.zshrc`.
You will see `.rc.general` tries to
source those files at the right condition.

`.rc.private` is encrypted by gpg.
It stores some private configurations
that shouldn't be shared by the public.

Other files are just some tweaks
for specific OS.

All the files mentioned in this section
are stored in `.helper/shell/`
and are symbolically linked
in both `zsh/.config/zsh/config/`
and `bash/.config/bash/config/`
for convenience.
If the file structure
in `.helper/shell/` is modified,
we can use a simple script
`dotfiles-update` to update
the symbolic links.

##### .zsh.local

Some settings are only meaningful
to a local machine.

For example,
some `alias` to folders and files,
expose `homebrew` or `linuxbrew`,
or some other libraries.

Those settings should be saved into
`zshrc.local` or `bashrc.local`
in `$HOME` directory.


### bash

My bash configuration
isn't as fancy as zsh.
I mainly use it
when I ssh into some
remote machines.

It shares many files
with `zsh`,
as mentioned in
[.rc.general](#rcgeneral),
and it sources `$HOME/.bashrc.local`
for some local settings just like `zsh`.





