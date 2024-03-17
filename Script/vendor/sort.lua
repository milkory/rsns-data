local sort = {}
local _swap = function(list, i, j)
  local temp = list[i]
  list[i] = list[j]
  list[j] = temp
end
local _bubble_sort = function(list, compFunc, l, r)
  l = l or 1
  r = r or #list
  for i = l, r do
    for j = l, r - (i - l) - 1 do
      if compFunc(list[j], list[j + 1]) then
        _swap(list, j, j + 1)
      end
    end
  end
end

local function _quick_sort(list, l, r, compFunc)
  if r <= l then
    return
  end
  local pivot = list[r]
  local pos = l
  while r > pos and compFunc(list[pos], pivot) do
    pos = pos + 1
  end
  for i = pos, r - 1 do
    if compFunc(list[i], pivot) then
      _swap(list, i, pos)
      pos = pos + 1
    end
  end
  _swap(list, pos, r)
  _quick_sort(list, l, pos - 1, compFunc)
  _quick_sort(list, pos + 1, r, compFunc)
end

function sort.SoryByFuncion(list, compFunc, l, r)
  l = l or 1
  r = r or #list
  _bubble_sort(list, compFunc, l, r)
end

return sort
