--Load impatient as the first thing
local has_impatient, impatient = pcall(require, "impatient")
if has_impatient then impatient.enable_profile() end

-- Core settings, options, and keymaps
require("core")

-- Utility with helper functions and constants
-- Make it a global variable
Utils = require("utils")

-- Plugin managed via Packer
require("plugin")
