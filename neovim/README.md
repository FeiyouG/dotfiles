# Neovim Config

<!-- TOC GFM -->

- [On your first use](#on-your-first-use)
- [Further configure nvim](#further-configure-nvim)
- [Treesitters](#treesitters)
- [LSP](#lsp)
- [Debuggers](#debuggers)
  - [Python](#python)
  - [Java](#java)

<!-- /TOC -->

## On your first use

1.  On your first start of nvim (>= 0.7),
    you may see some errors.
    Ignore the all errors by pressing `q`.
    Then, wait a few seconds,
    all plugins will be automatically installed.
1.  When all plugins are installed,
    quit and restart nvim.
    on your second start,
    treesitters and LSPs will be automatically installed.
1.  Then,
    you can start using nvim as usual

## Further configure nvim

## Treesitters

To add/remove treesitters parsers:
1. Go to `.config/nvim/lua/plugin/treesitter/nvim-treesitter.lua`
1. Add/remove parsers in `ensure_installed` table
1. Restart nvim and run `:PackerCompile`

## LSP

To add/remove lsp:
1. Go to `.config/nvim/lua/plugin/lsp/servers/init.lua`
1. Add/remove servers
1. If you want to configure a server,
   put the configuration inside a new file
   inside the folder `servers/`
   and require it in `servers/init.lua`.
   The configure file should return a table
   that
1. Restart nvim and run `:PackerCompile`

### Java

Note jdtls only works with java17 or newer. 
If Jdtls can't start properly, 
please first check if you have the right version of java installed

## Debuggers

### Python

Create a new virtualenv
and install `debugpy`:
```bash
cd $XDG_DATA_HOME/virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

### Java


1. Make sure
  [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
  and [nvim-dap](https://github.com/mfussenegger/nvim-dap).
  are installed first.
1. Clone [java-debug](https://github.com/microsoft/java-debug)
  into `$XDG_DATA_HOME/java`
    - Run `./mvnw clean install`
      inside `java-debug` repository.
1. Clone [vscode-java-test](https://github.com/microsoft/vscode-java-test)
  into `$XDG_DATA_HOME/java`
    - Run `npm install`
      inside `vscode-java-test` repository
    - Run `npm run build-plugin`
      inside `vscode-java-test` repository

*References*:
- [nvim-jdtls#Debugger](https://github.com/mfussenegger/nvim-jdtls#debugger-via-nvim-dap)



