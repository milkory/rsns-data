function table.count(t)
  local count = 0
  
  for i, v in pairs(t) do
    count = count + 1
  end
  return count
end

function table.GetTableState(list)
  if list ~= nil and table.count(list) > 0 then
    return true
  end
  return false
end

function GetTimeData(time)
  local tl = {}
  tl.day = math.floor(time / 60 / 60 / 24)
  tl.hour = math.floor(time / 3600) % 24
  tl.minute = math.floor(time / 60) % 60
  tl.second = math.floor(time % 60)
  if tl.hour > 0 then
    if tl.second < 10 then
      local second = "0" .. tl.second
      return tl.hour .. ":" .. tl.minute .. ":" .. second
    else
      return tl.hour .. ":" .. tl.minute .. ":" .. tl.second
    end
  end
  if tl.minute > 0 and tl.minute < 10 then
    if tl.second < 10 then
      local second = "0" .. tl.second
      return "0" .. tl.minute .. ":" .. second
    else
      return "0" .. tl.minute .. ":" .. tl.second
    end
  end
  if tl.second >= 0 then
    return "00" .. ":" .. tl.second
  end
  return ""
end

local find = function(a, tbl)
  for _, a_ in ipairs(tbl) do
    if a_ == a then
      return true
    end
  end
end

function table:Difference(a, b)
  local row = {}
  local count = 0
  for _, a_ in ipairs(a) do
    if a_ ~= b[_] then
      count = count + 1
      table.insert(row, b[_])
    end
  end
  return count, row
end

function table:NewDifference(a, b)
  local row = {}
  local count = 0
  local a_count = table.count(a)
  local b_count = table.count(b)
  if a_count == 0 then
    if b_count == 0 then
      return count, row
    else
      return b_count, b
    end
  elseif b_count == 0 then
    return a_count, a
  else
    if a_count < b_count then
      for _, b_ in pairs(b) do
        if a[_] == nil then
          count = count + 1
          table.insert(row, b_)
        end
      end
      return count, row
    end
    if a_count > b_count then
      for _, a_ in pairs(a) do
        if b[_] == nil then
          count = count + 1
          table.insert(row, a_)
        end
      end
      return count, row
    end
  end
  return count, row
end
