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
1. (opencode) Install agent skills & tools:
    ```shell
    ~/.config/opencode/scripts/sync-skills.sh
    ```
    This installs (all globally, nothing written into the repo):
    - skills listed in `opencode/.config/opencode/skills-lock.json` → `~/.agents/skills/`
      (private sources need GitHub SSH access)
    - [OpenSpec](https://github.com/Fission-AI/OpenSpec) skills and `/opsx:*` commands
      → `~/.config/opencode/{skills,commands}/` (git-ignored).
      Re-run the script after `brew upgrade openspec`.
      In a new project, run `openspec init --tools none` once to create `openspec/`.
    - [Plannotator](https://github.com/backnotprop/plannotator) binary and `/plannotator-*`
      commands (the plan-review plugin itself is set in `opencode.json`)

    To add a skill, record it in the lock, then sync:
    ```shell
    cd ~/.config/opencode
    npx skills add <owner/repo> --skill <name> -a opencode -y   # updates skills-lock.json
    ./scripts/sync-skills.sh
    ```
    To remove one, delete its entry from `skills-lock.json` and
    `rm -rf ~/.agents/skills/<name>`.
1. Restart zsh,
    zinit and zsh plugins will be installed automatically.
1. Start nvim, 
    plugins, lsps, and treesitters will be installed automatically.
1. Start tmux,
    tpm and plugins will be installed automatically.

## License
[MIT](https://opensource.org/licenses/MIT).
