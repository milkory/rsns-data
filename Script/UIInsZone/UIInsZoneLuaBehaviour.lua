local View = require("UIInsZone/UIInsZoneView")
local DataModel = require("UIInsZone/UIInsZoneDataModel")
local ViewFunction = require("UIInsZone/UIInsZoneViewFunction")
local Controller = require("UIInsZone/UIInsZoneDataController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.SetJsonData(initParams)
    DataModel.InitData()
    Controller.RefreshOnShow()
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
