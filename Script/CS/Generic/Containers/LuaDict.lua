local LuaDict = {}
LuaDict.__index = LuaDict
LuaDict.csDict = {}

function LuaDict.New(csDict)
  local t = setmetatable({}, LuaDict)
  t:SetCSDict(csDict)
  return t
end

function LuaDict:IsCsDictNil()
  return self.csDict == nil
end

function LuaDict:SetCSDict(csDict)
  self.csDict = csDict
end

function LuaDict:ContainsKey(key)
  if self:IsCsDictNil() then
    return false
  end
  return self.csDict:ContainsKey(key)
end

function LuaDict:Add(key, value)
  if self:ContainsKey(key) then
    return
  end
  self.csDict:Add(key, value)
end

function LuaDict:GetCsDict()
  return self.csDict
end

return LuaDict
