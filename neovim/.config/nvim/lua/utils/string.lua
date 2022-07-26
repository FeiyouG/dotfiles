local M = {}

M.split = function(input_str, delimeter)
  input_str = input_str or ""
  delimeter = delimeter or "%s"

  local res = {}

  for str in string.gmatch(input_str, "([^" .. delimeter .. "]+)") do
    table.insert(res, str)
  end
  return res
end

M.to_snake_case = function(str)
  local words = M.split(str, " ")
  return table.concat(words, "_")
end

M.separate_snake_case = function(str)
  local words = M.split(str, "_")
  return table.concat(words, " ")
end

return M
