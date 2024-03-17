local View = require("UIEquipCompare/UIEquipCompareView")
local DataModel = require("UIEquipCompare/UIEquipCompareDataModel")
local ViewFunction = require("UIEquipCompare/UIEquipCompareViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.RoleId = data.RoleId
    DataModel.Index = data.Index
    DataModel.ReplaceEid = data.ReplaceEid
    DataModel.CurrEid = PlayerData:GetRoleById(data.RoleId).equips[DataModel.Index]
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
