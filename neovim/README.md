# Neovim Config

## Plugins

## Treesitters

## LSP

## Debuggers

### Python

### Java


### Debugging

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

### Dependencies
1. `lombok`:
    - Download [lombok.jar]()
      into `$XDG_DATR_HOME/java`
      if you are gonna work with `lombok`.


*References*:
- [nvim-jdtls#Debugger](https://github.com/mfussenegger/nvim-jdtls#debugger-via-nvim-dap)



