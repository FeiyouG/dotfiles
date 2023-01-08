-- Core plugins that required to be loaded at the beinging of the setup
return {
  { 'lewis6991/impatient.nvim' },
  require("plugin.core.exrc"),
  require("plugin.core.packer"),
  require("plugin.core.nvim-notify"),
  require("plugin.core.command_center"),
}
