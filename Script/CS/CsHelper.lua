local CsHelper = {}
local LuaDict = require("CS/Generic/Containers/LuaDict")
local LuaList = require("CS/Generic/Containers/LuaList")
CsHelper.CsTypeStr = CS.System.String
CsHelper.CsTypeObj = CS.System.Object

function CsHelper.NewLuaDict(csType1, csType2)
  local csDict = CS.System.Collections.Generic.Dictionary(csType1, csType2)
  return LuaDict.New(csDict())
end

function CsHelper.NewLuaDictStrObj()
  return CsHelper.NewLuaDict(CsHelper.CsTypeStr, CsHelper.CsTypeObj)
end

function CsHelper.NewLuaList(csType)
  local csList = CS.System.Collections.Generic.List(csType)
  return LuaList.New(csList())
end

function CsHelper.NewLuaListStr()
  return CsHelper.NewLuaList(CsHelper.CsTypeStr)
end

return CsHelper
