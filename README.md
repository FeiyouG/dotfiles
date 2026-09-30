# Feiyou's dotfiles


<!-- TOC GFM -->

- [Usage](#usage)
- [License](#license)

<!-- /TOC -->

The structure of this repository
is inspired by [Alex Pearce](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
and [Abdullah Khabir](https://abdullah.today/encrypted-dotfiles/).

## Usage

1. [Install Homebrew](https://brew.sh)
    - Don't forget to add 
      `eval "$(/opt/homebrew/bin/brew shellenv)`
      to your `$HOME/.zshrc`
1. Clone this repository into your `$HOME` folder.
    ```shell
    $ git clone git@github.com:gfeiyou/dotfiles.git $HOME/.dotfiles
    $ cd $HOME/.dotfiles
    ```
1. Install tools from Brewfile (stow, tmux, nvim, ...)
    ```shell
    brew bundle
    ```
    This also installs the fonts: Victor Mono and the Nerd Fonts v3
    `Symbols Nerd Font` (icons for nvim/tmux via terminal font fallback).
    Restart the terminal afterwards. Keep icon glyphs on Nerd Fonts v3 codepoints
    (`brew install nerdfix && nerdfix check -r <path>` finds obsolete ones).
1. Stow needed config
    ```shell
    stow wezterm nvim tmux ...
    ```
1. (opencode) Provide secrets referenced by `opencode.json`, which are not tracked:
    ```shell
    mkdir -p ~/.config/opencode/secrets
    printf '%s' '<treg token>' > ~/.config/opencode/secrets/treg-token
    ```
1. Restart zsh,
    zinit and zsh pluins will be installed automatically.
1. Start nvim, 
    plugins, lsps, and treesitters will be isntalled automatically .
1. Start tmux,
    tpm and plugins will be installed automatially.

## License
[MIT](https://opensource.org/licenses/MIT).
