---Check if current repo is a vue project
---@return boolean
local function is_inside_vue_repo()
  -- Check for common Vue project files in the root directory
  local root_files = {
    'vite.config.ts',
    'vue.config.js',
    '.vuerc',
    'package.json',
  }

  local root_path = vim.fn.getcwd() -- You might need to adjust this for multi-module repos or monorepos

  -- Function to check if a file exists in the root directory of the project
  local function file_exists_in_root(file_name)
    local full_path = root_path .. '/' .. file_name
    return vim.fn.filereadable(full_path) == 1
  end

  -- Check each root file for indicators of a Vue project
  for _, file_name in ipairs(root_files) do
    if file_exists_in_root(file_name) then
      if file_name == 'package.json' then
        -- Read the package.json file and check for Vue dependencies
        local package_json = vim.fn.json_decode(vim.fn.readfile(root_path .. '/package.json'))
        if package_json.dependencies and (package_json.dependencies.vue or package_json.devDependencies["@vue/compiler-sfc"]) then
          return true
        end
      else
        -- If it's not the package.json, its mere existence is a strong Vue project indicator
        return true
      end
    end
  end

  return false
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.tsserver = {
        handlers = {
          ['textDocument/publishDiagnostics'] = is_inside_vue_repo() and function()
            print("tsserver has been disabled for this Vue project.")
          end or nil
        }
      }
      return opts
    end,
  }
}
