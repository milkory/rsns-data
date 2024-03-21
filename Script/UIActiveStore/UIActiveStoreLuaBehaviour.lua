local View = require("UIActiveStore/UIActiveStoreView")
local DataModel = require("UIActiveStore/UIActiveStoreDataModel")
local Controller = require("UIActiveStore/UIActiveStoreController")
local ViewFunction = require("UIActiveStore/UIActiveStoreViewFunction")
local tempParams = {}
local Luabehaviour = {
  serialize = function()
    return Json.encode(tempParams)
  end,
  deserialize = function(initParams)
    if initParams then
      local params = Json.decode(initParams)
      tempParams = params
      DataModel.StoreCA = params.ca
      DataModel.ActivityId = params.activityId
      DataModel.ShopId = params.shopId
      Controller:Init(true)
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
