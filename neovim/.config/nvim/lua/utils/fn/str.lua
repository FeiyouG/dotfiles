local M = {}

-- Split input based on delimeter
-- @param input string: the string to be splitted
-- @param delimeter string: the delimeter used to split the string
-- @return a list of string
M.split = function(input, delimeter)
  input = input or ""
  delimeter = delimeter or "%s"

  local res = {}

  for str in string.gmatch(input, "([^" .. delimeter .. "]+)") do
    table.insert(res, str)
  end
  return res
end

-- Convert str to snake case
M.to_snake_case = function(str)
  local words = M.split(str, " ")
  return table.concat(words, "_")
end

-- Convert str from snake case to space seperated words
M.separate_snake_case = function(str)
  local words = M.split(str, "_")
  return table.concat(words, " ")
end

return M
