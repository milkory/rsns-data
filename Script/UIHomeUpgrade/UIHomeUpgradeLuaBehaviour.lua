local View = require("UIHomeUpgrade/UIHomeUpgradeView")
local DataModel = require("UIHomeUpgrade/UIHomeUpgradeDataModel")
local Controller = require("UIHomeUpgrade/UIHomeUpgradeController")
local ViewFunction = require("UIHomeUpgrade/UIHomeUpgradeViewFunction")
local Luabehaviour = {
  serialize = function()
    if DataModel.cacheData then
      return Json.encode(DataModel.cacheData)
    end
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local data = Json.decode(initParams)
      DataModel.cacheData = data
      DataModel.curFurUfid = data.furUfid
      DataModel.curFurId = data.furId
      Controller:Init()
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataModel.CostItems = nil
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
