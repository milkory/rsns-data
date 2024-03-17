local View = require("UIWeaponStore/UIWeaponStoreView")
local DataModel = require("UIWeaponStore/UIWeaponStoreDataModel")
local ViewFunction = require("UIWeaponStore/UIWeaponStoreViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.StoreId = t.storeId
      DataModel.StoreCA = PlayerData:GetFactoryData(t.storeId)
      DataModel:Init(t.inited)
    else
      DataModel:Init(true)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
