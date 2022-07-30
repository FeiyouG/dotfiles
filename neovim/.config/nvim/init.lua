-- Load impatient as the first thing
local has_impatient, impatient = pcall(require, "impatient")
if has_impatient then impatient.enable_profile() end

-- All non plugin related options
require("options")

-- Neovim mapping
require("mappings")

-- Neovim Autocommands
require("autocommands")

-- global utility functions and constants
require("utils")

-- Plugin management via Packer
require("plugin")
