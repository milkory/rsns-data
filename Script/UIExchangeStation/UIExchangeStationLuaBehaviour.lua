local View = require("UIExchangeStation/UIExchangeStationView")
local DataModel = require("UIExchangeStation/UIExchangeStationDataModel")
local ViewFunction = require("UIExchangeStation/UIExchangeStationViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.isWeaponReady = false
    if initParams ~= nil then
      local t = Json.decode(initParams)
      local buildingId = t.buildingId
      local buildCA = PlayerData:GetFactoryData(buildingId)
      DataModel.BuildCA = buildCA
      if buildCA.stationId ~= nil and buildCA.stationId > 0 then
        DataModel.StationId = tostring(buildCA.stationId)
      else
        DataModel.StationId = tostring(t.stationId)
      end
      if buildCA.npcId ~= nil and 0 < buildCA.npcId then
        DataModel.NpcId = buildCA.npcId
      else
        DataModel.NpcId = t.npcId
      end
      if buildCA.bgPath ~= nil and buildCA.bgPath ~= "" then
        DataModel.BgPath = buildCA.bgPath
      else
        DataModel.BgPath = t.bgPath
      end
      DataModel.BgColor = buildCA.bgColor or "FFFFFF"
      DataModel.BgColor = "#" .. DataModel.BgColor
      DataModel.StationName = t.name
      DataModel.StationList = PlayerData:GetHomeInfo().stations[DataModel.StationId]
      DataModel.StationState = DataModel.StationList.state
      DataModel.Index_OutSide = 1
      DataModel.InitMode = t.initMode
      DataModel.HelpId = t.helpId
      DataModel.HideBg = t.hideBg
      DataModel:Init(true)
    else
      DataModel:Init()
      if View.Group_Exchange.IsActive then
        DataModel:OpenStorePage(true)
      end
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
