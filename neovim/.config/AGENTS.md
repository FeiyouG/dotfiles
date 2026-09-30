# AGENTS.md - Development Guide for Neovim Configuration

This file provides essential guidelines for agentic coding agents working in this Neovim configuration repository.

## Project Overview

This is a Lua-based Neovim configuration using Lazy.nvim as the plugin manager. The configuration follows a modular architecture with 52+ Lua files organized under `lua/settings/` and `lua/plugins/`. There is no traditional build process - the configuration validates when Neovim starts up.

## Build/Lint/Test Commands

### Validation Commands
```bash
# Check configuration syntax
nvim --checkconfig

# Test config loads without errors (headless mode)
nvim --headless +qa

# Run Neovim health checks
nvim --headless +"lua vim.health.check()" +qa
```

### Linting and Formatting
The configuration uses None-ls for linting and formatting. Commands are run within Neovim:

```vim
" View active linters/formatters
:NullLsInfo

" Generate debug info for linting issues
:lua require('null-ls').debug.generate_info()

" Format current buffer
:lua vim.lsp.buf.format()
```

### Individual Component Testing
```bash
# Test specific plugin configuration
nvim --headless +"lua require('plugins.python').setup()" +qa

# Test specific settings module
nvim --headless +"lua require('settings.fn.utils')" +qa
```

## Code Style Guidelines

### Formatting
- **Indentation**: 2 spaces (tabstop=2, shiftwidth=2)
- **Tabs**: Convert to spaces (expandtab=true)
- **Line length**: 80 characters (colorcolumn=80)
- **End of file**: Single newline character

### Naming Conventions
- **Files**: snake_case.lua (e.g., `keymaps.lua`, `options.lua`)
- **Functions**: snake_case (e.g., `get_capabilities()`, `is_callable()`)
- **Variables**: snake_case for locals, UPPER_CASE for constants
- **Modules**: Use `local M = {}` pattern for utility modules
- **Global settings**: Access via `_G.settings` namespace

### Imports and Dependencies
```lua
-- Standard imports at top of file
require("settings.path")
require("settings.icons")

-- Local module pattern
local utils = require("settings.fn.utils")

-- Plugin specs return tables
return {
  {
    "plugin/author/repo",
    config = function() end
  }
}
```

### Type Annotations
Use LSpr type hints for all public functions:
```lua
---@param obj any The object to be checked
---@return boolean is_callable true if obj is callable
function M.is_callable(obj)
  -- implementation
end
```

### Module Structure
Follow the established patterns:

**Settings modules** (`lua/settings/`):
```lua
local M = {}

-- Section comments for organization
-- SECTION: Category Name
-- Configuration code here

return M
```

**Plugin specifications** (`lua/plugins/`):
```lua
return {
  {
    "author/plugin-name",
    event = { "BufReadPre" },
    dependencies = { "required/plugin" },
    config = function(_, opts)
      -- Plugin configuration
    end,
    opts = function(_, opts)
      return vim.list_extend(opts, additional_opts)
    end,
  }
}
```

### Error Handling
- Use `settings.fn.is_callable(obj)` before calling functions
- Use `vim.notify(message, level)` for user-facing messages
- Provide graceful fallbacks for optional dependencies
- Check file existence with `vim.loop.fs_stat(path)`

### LSP Configuration Patterns
- All LSP servers configured through `lua/plugins/lsp.lua`
- Use `settings.fn.lsp.on_attach` for common LSP behavior
- Extend default capabilities with `vim.tbl_extend()`
- Server-specific configs in `lua/plugins/lang/*.lua`

### Key Patterns from Codebase

**Configuration Merging**:
```lua
opts = function(_, opts)
  return vim.list_extend(opts, {
    require("null-ls").builtins.formatting.black,
  })
end
```

**Path Management**:
```lua
-- Use settings.path for all file paths
local spell_file = require("settings.path").spell.spellfile
```

**OS Detection**:
```lua
local os_name = settings.fn.utils.os_name() -- Returns "mac", "win", "linux", "unknown"
```

**Project Root Detection**:
```lua
local root = settings.fn.utils.project_root({ ".git", "pyproject.toml" })
```

### Testing Individual Features
When working on specific functionality:
1. Test syntax with `nvim --checkconfig`
2. Load specific modules in headless mode
3. Use `:lua` in Neovim for interactive testing
4. Check `:NullLsInfo` for linting issues

### Common Gotchas
- Always check if executables exist before using them (`vim.fn.executable()`)
- Use proper event triggers for plugin loading
- Maintain backward compatibility with Neovim 0.7+
- Respect the modular structure - avoid circular dependencies
- Use vim.tbl_deep_extend for nested table merging

## Language-Specific Notes

**Python**: Uses black, isort, and pylsp via None-ls
**TypeScript**: Uses tsserver via LSP
**Lua**: No external linter - relies on Neovim's built-in checking

Remember: This is a configuration that loads directly into Neovim. Test thoroughly with `nvim --headless` before committing changes.