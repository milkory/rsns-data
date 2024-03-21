local View = require("UIHomeCOC/UIHomeCOCView")
local DataModel = require("UIHomeCOC/UIHomeCOCDataModel")
local Controller = require("UIHomeCOC/UIHomeCOCController")
local ViewFunction = require("UIHomeCOC/UIHomeCOCViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {}
    t.stationId = DataModel.StationId
    t.buildingId = DataModel.BuildingId
    t.npcId = DataModel.NpcId
    t.bgPath = DataModel.BgPath
    t.bgColor = DataModel.BgColor
    t.noInit = true
    if View.Group_Quest.self.IsActive then
      t.backQuest = true
    end
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    DataModel.IsHomeReturn = false
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.StationId = t.stationId
      DataModel.BuildingId = t.buildingId
      DataModel.NpcId = t.npcId
      DataModel.BgPath = t.bgPath
      DataModel.BgColor = t.bgColor or "FFFFFF"
      local stationCA = PlayerData:GetFactoryData(t.stationId)
      if stationCA ~= nil then
        DataModel.ExchangeId = stationCA.cocExchangeBuildId
        local exchangeCA = PlayerData:GetFactoryData(stationCA.cocExchangeBuildId)
        if exchangeCA ~= nil then
          DataModel.ExchangeLevelLimt = exchangeCA.playerLevel
        end
      end
      if t.noInit then
        Controller:BackInit()
        if t.backQuest == true then
          Controller:ClickQuestTab(true)
        end
      else
        Controller:Init()
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if View.Group_Quest.self.IsActive then
      Controller:DayRefreshOrderPanel()
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    QuestProcess.RemoveQuestCallBack(View.self.url)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
