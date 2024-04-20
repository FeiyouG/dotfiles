# Neovim Config


<!-- TOC GFM -->

- [On your first use](#on-your-first-use)
- [Troubleshooting](#troubleshooting)
    - [Java](#java)
        - [Jdlts LSP quit unexpectedly](#jdlts-lsp-quit-unexpectedly)
        - [Java debugger not working](#java-debugger-not-working)
    - [Python](#python)
        - [Setup python debugger](#setup-python-debugger)

<!-- /TOC -->

## On your first use

1. Make sure nvim >= 0.7 is installed
2. Start neovim.
    You may see some errors and you can ignor them by pressing `q`.
    Wait a few seconds, all plugins will be automatically installed.
3. When all plugins are installed,
    quite and restart nvim.
    On this start, treesitters and LSPs will be automatically installed.
4. Then, you can start using nvim as usual.

## Troubleshooting

### Java

#### Jdlts LSP quit unexpectedly

1. Make sure
    you have java 11 (or above) installed
2. Make sure
  [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
  is correcly installed.

#### Java debugger not working

1. Make sure
    [nvim-dap](https://github.com/mfussenegger/nvim-dap)
    is correctly installed.
2. Inspect
    `setings.path.java` variable
    and see if any path is initialized incorrectly
    or dependencies are installed properly
3. If `java-debug-adapter` is not installed
    is not installed
    1. Clone [java-debug](https://github.com/microsoft/java-debug)
        into `$XDG_DATA_HOME/nvim/mason/packages`
        as `java-debug-adaptor`
    2. Run `./mvnw clean insatll`
        inside `java-debug-adaptor` repository
4. If `vscode-java-test` is not installed
    1. Clone [vscode-java-test](https://github.com/microsoft/vscode-java-test)
        into `$XDG_DATA_HOME/nvim/mason/packages`
        as `java-test`
    2. Run `npm run build-plugin`
        instaide `java-test` repository

### Python

#### Setup python debugger

Create a new virtualenv and install `debugpy`

```shell
cd $XDG_DATA_HOME/virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```
