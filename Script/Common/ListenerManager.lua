local ListenerManager = {}
ListenerManager.Enum = {
  SetQuestTrace = 1,
  CompleteQuestInQuestTrace = 2,
  RemoveQuestTrace = 3,
  StationStateChange = 4,
  CompleteQuest = 5
}
local listener = {}
local defaultKey = "listenerCustom"
local sortFunc = {
  [1] = {
    "QuestTraceUIShow"
  }
}

function ListenerManager.Broadcast(enum, ...)
  if listener[enum] ~= nil then
    local cacheCalledFunc = {}
    if sortFunc[enum] then
      for k, v in pairs(sortFunc[enum]) do
        if listener[enum][v] then
          listener[enum][v](...)
          cacheCalledFunc[v] = 1
        end
      end
    end
    for k, v in pairs(listener[enum]) do
      if k == defaultKey then
        for k1, v1 in pairs(v) do
          v1(...)
        end
      elseif cacheCalledFunc[k] == nil then
        v(...)
      end
    end
  end
end

local overload = function()
  local mt = {}
  local errorFunc = function()
    print_r("listener no match function!!!")
  end
  
  function mt:__call(...)
    local arg = {
      ...
    }
    local types = {}
    for i = 1, select("#", ...) do
      types[#types + 1] = type(arg[i])
    end
    local strType = table.concat(types, "_")
    return (self[strType] or self.default)(...)
  end
  
  return setmetatable({default = errorFunc}, mt)
end
local addListener = overload()

function addListener.number_string_function(enum, key, func)
  if listener[enum] == nil then
    listener[enum] = {}
  end
  listener[enum][key] = func
end

function addListener.number_function(enum, func)
  if listener[enum] == nil then
    listener[enum] = {}
  end
  if listener[enum][defaultKey] == nil then
    listener[enum][defaultKey] = {}
  end
  table.insert(listener[enum][defaultKey], func)
end

ListenerManager.AddListener = addListener
local removeListener = overload()

function removeListener.number_string(enum, key)
  if listener[enum] ~= nil then
    if key ~= nil then
      listener[enum][key] = nil
    else
      listener[enum] = nil
    end
  end
end

function removeListener.number_function(enum, func)
  if listener[enum] ~= nil then
    local defaultFuncTable = listener[enum][defaultKey] or {}
    for k, v in pairs(defaultFuncTable) do
      if v == func then
        table.remove(defaultFuncTable, k)
        break
      end
    end
  end
end

ListenerManager.RemoveListener = removeListener

function ListenerManager.ClearAllListener()
  listener = {}
end

return ListenerManager
