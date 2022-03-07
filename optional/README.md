## Optional

Files and configurations in this directory
can be optionally added.

Note: be careful to use stow when 
specify stow and target directory. 
For example:
```shell
cd $HOME/.dotfiles
stow -d optional -t $HOME --ignore="README.md" shell
```

If you have linked `dotfiles/bin`
and have `alias stow=stow_extended` 
in your .*rc file,
or already have `.aliases` file in `$HOME` 
links to `optional/shell/.aliases`
(which created such alias automatically),
then you can use this short hand instead:
```shell
cd $HOME/.dotfiles
stow optional/shell
``` 
