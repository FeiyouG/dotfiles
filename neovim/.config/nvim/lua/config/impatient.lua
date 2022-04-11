-- Reduced from about 86ms to 9ms
require("impatient").enable_profile()

require("command_center").add({
  {
    description = "Show plugin cache report",
    command = "LuaCacheProfile",
  }, {
    description = "Clear plugin cache",
    command = "LuaCacheClear",
  }
})

