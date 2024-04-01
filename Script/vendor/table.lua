function _Assert(_table, kvTable)
  local isAllSame = true
  
  for key, value in pairs(kvTable) do
    if _table[key] ~= value then
      isAllSame = false
      _table[key] = value
    end
  end
  return isAllSame
end

function Clone(origin)
  local origin_type = type(origin)
  local copy
  if origin_type == "table" then
    copy = {}
    for k, v in next, origin, nil do
      copy[Clone(k)] = Clone(v)
    end
  else
    copy = origin
  end
  return copy
end

function ReverseTable(tab)
  local tmp = {}
  for i = 1, #tab do
    local key = #tab
    tmp[i] = table.remove(tab, key)
  end
  return tmp
end

function ListContainsValue(list, value)
  assert(list ~= nil and value ~= nil, "数据错误！")
  for i, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end
