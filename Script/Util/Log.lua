local function genTable(t, newT, index)
  if type(t) ~= "table" then
    table.insert(newT, tostring(t))
    
    return
  end
  local temp = {}
  for i, v in pairs(t) do
    table.insert(temp, {i = i, v = v})
  end
  table.sort(temp, function(a, b)
    local tempA = tonumber(a.i)
    local tempB = tonumber(b.i)
    if tempA and tempB and tempA ~= tempB then
      return tempA < tempB
    end
    return tostring(a.i) < tostring(b.i)
  end)
  for _, v in ipairs(temp) do
    local str = type(v.i) == "number" and string.format("[%d]", v.i) or string.format("[\"%s\"]", tostring(v.i))
    if type(v.v) == "table" then
      str = str .. " = {"
      local newStr = "},"
      for i = 1, index do
        str = "\t" .. str
        newStr = "\t" .. newStr
      end
      table.insert(newT, str)
      genTable(v.v, newT, index + 1)
      table.insert(newT, newStr)
    else
      str = str .. " = " .. tostring(v.v)
      for i = 1, index do
        str = "\t" .. str
      end
      table.insert(newT, str)
    end
  end
end

local log = function(...)
  local t = {
    ...
  }
  local newT = {}
  if 1 < #t or #t == 1 and type(t[1]) == "table" then
    table.insert(newT, "{")
  end
  genTable(#t == 1 and t[1] or t, newT, 1)
  if 1 < #t or #t == 1 and type(t[1]) == "table" then
    table.insert(newT, "}")
  end
  if 500 < #newT then
    local resultTable = {}
    for i = 1, #newT, 500 do
      local chunk = {}
      for j = i, i + 500 - 1 do
        if newT[j] then
          table.insert(chunk, newT[j])
        else
          break
        end
      end
      table.insert(resultTable, chunk)
    end
    return true, resultTable
  else
    return false, newT
  end
end

function print_r(...)
  local isHaveChunk, chunks = log(...)
  if isHaveChunk then
    print("<color=#FFC0CB>=======================日志太长，开始分块=======================</color>")
    for i, v in ipairs(chunks) do
      print(string.format("<color=#FFC0CB>chunk: %d</color>", i))
      local s = table.concat(v, "\n")
      print(s)
    end
    print("<color=#FFC0CB>=======================分块结束=========================</color>")
  else
    local s = table.concat(chunks, "\n")
    print(s)
  end
end

function logError(err)
  CS.UnityEngine.Debug.LogError(err .. debug.traceback())
end

function logWarning(warning)
  CS.UnityEngine.Debug.LogWarning(warning .. debug.traceback())
end
