local View = require("UIConstructStage/UIConstructStageView")
local DataModel = require("UIConstructStage/UIConstructStageDataModel")
local ViewFunction = require("UIConstructStage/UIConstructStageViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.StationId = t.stationId
      DataModel.StationCA = PlayerData:GetFactoryData(t.stationId)
      DataModel.ConstructNowCA = t
      DataModel.Index_Construct = t.Index_Construct
      DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(t.stationId)]
      DataModel:Init()
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
