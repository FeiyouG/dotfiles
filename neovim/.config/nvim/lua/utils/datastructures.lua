-- MARK: Stack and Queue
Stack = {}
function Stack:push(e)
	self[#self + 1] = e
end

function Stack:pop()
	if #self == 0 then
		return nil
	end
	local e = self[#self]
	self[#self] = nil
	return e
end

function Stack:peek()
	if #self == 0 then
		return nil
	end
	return self[#self]
end

Queue = {}
function Queue:add(e)
	self[#self + 1] = e
end

function Queue:remove()
	if #self == 0 then
		return nil
	end
	local e = self[0]
	self[0] = nil
	return e
end

function Queue:peek()
	if #self == 0 then
		return nil
	end
	return self[0]
end


-- MARK: List
List = {}

---Return the first element in the list
---If array is empty, return default
function List:first(default)
	if #self == 0 then
		return default
	end
	return self[1]
end

---Return the last element in the list
---If array is empty, return default
function List:last(default)
	if #self == 0 then
		return default
	end
	return self[#self]
end

function List:append(e)
	self[#self + 1] = e
end

function List:sort(func)
  table.sort(self, func)
end

function NewList(tbl)
  setmetatable(tbl, { __index = List })
  return tbl
end
