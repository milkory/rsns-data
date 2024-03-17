local LuaList = {}
LuaList.__index = LuaList
LuaList.csList = {}

function LuaList.New(csList)
  local t = setmetatable({}, LuaList)
  t:SetCsList(csList)
  return t
end

function LuaList:GetCsList()
  return self.csList
end

function LuaList:SetCsList(csList)
  self.csList = csList
end

function LuaList:Add(value)
  self.csList:Add(value)
end

return LuaList
