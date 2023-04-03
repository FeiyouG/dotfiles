local M = {}

--- Merge two or more tables together
function M.tbl_merge(...)
  if select('#', ...) < 1 then return {} end
  if select('#', ...) < 2 then return select(1, ...) end

  local res = {}
  for i = 1, select('#', ...) do
    local tbl = select(i, ...)
    for k, v in pairs(tbl) do
      res[k] = M.tbl_merge(tbl[k])
    end
  end

  return res
end

return M
