local M = {}

M.lsp = require("Utils.path.lsp")
M.dap = require("Utils.path.dap")
M.plugin = require("Utils.path.plugin")

M.sep = require("utils.system").os_name == "win" and "\\" or "/"

-- MARK: Methods
---Concatenate paths
M.join = function(...)
  return table.concat(vim.tbl_flatten { ... }, M.sep)
end

---Check whether directory exist on path
M.dir_exists = function(path)
  return vim.fn.isdirectory(vim.fn.glob(path)) == 1
end

---Check whether file exists on path
M.file_exists = function(path)
  return vim.fn.filereadable(vim.fn.glob(path)) == 1
end

---Create path recursively if path doesn't exit
M.safe_path = function(path)
  vim.api.nvim_exec("!safe_path " .. path, false)
end

M.get_root = function(markers, bufname)
  bufname = bufname or vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local dirname = vim.fn.fnamemodify(bufname, ':p:h')
  local getparent = function(p)
    return vim.fn.fnamemodify(p, ':h')
  end
  while getparent(dirname) ~= dirname do
    for _, marker in ipairs(markers) do
      if vim.loop.fs_stat(M.join(dirname, marker)) then
        return dirname
      end
    end
    dirname = getparent(dirname)
  end
end

return M
