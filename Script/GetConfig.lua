local declaredNames = {}

function declare(name)
  declaredNames[name] = true
end

_dataCache = {}
setmetatable(_dataCache, {
  __newindex = function(t, n, v)
    if not declaredNames[n] then
      error("尝试写入未声明的变量: " .. n, 2)
    else
      rawset(t, n, v)
    end
  end,
  __index = function(t, n)
    if not declaredNames[n] then
      error("尝试读取未声明的变量: " .. n, 2)
    else
      return rawget(t, n)
    end
  end
})

function GetCA(id, factoryName)
  local id = tonumber(id)
  if id == nil or id < 10000000 or 99999999 < id then
    return
  end
  declare(id)
  if _dataCache[id] then
    return _dataCache[id]
  end
  factoryName = factoryName or DataManager:GetFactoryNameById(id)
  declare(factoryName)
  if _dataCache[factoryName] then
    return _dataCache[factoryName][id]
  end
  DataManager:CacheCAToLua(id)
  return _dataCache[id]
end

function RefreshCA(id, factoryName)
  local id = tonumber(id)
  if id == nil or id < 10000000 or 99999999 < id then
    print_r(factoryName .. "恭喜你，给了一个错误的值进来...id--" .. tostring(id))
    return
  end
  declare(id)
  if _dataCache[id] then
    _dataCache[id] = nil
  end
  factoryName = factoryName or DataManager:GetFactoryNameById(id)
  declare(factoryName)
  if _dataCache[factoryName] and _dataCache[factoryName][id] then
    _dataCache[factoryName][id] = nil
  end
  DataManager:CacheCAToLua(id, true)
end

function CacheFactory(factoryName)
  declare(factoryName)
  DataManager:CacheFactory(factoryName)
end

function CacheAndGetFactory(factoryName)
  declare(factoryName)
  if _dataCache[factoryName] then
    return _dataCache[factoryName]
  end
  CacheFactory(factoryName)
  return _dataCache[factoryName]
end
