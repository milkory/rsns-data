local View = require("UIHomePetStore/UIHomePetStoreView")
local DataModel = require("UIHomePetStore/UIHomePetStoreDataModel")
local Controller = require("UIHomePetStore/UIHomePetStoreController")
local ViewFunction = require("UIHomePetStore/UIHomePetStoreViewFunction")
local Luabehaviour = {
  serialize = function()
    if DataModel.CacheInitParams then
      return Json.encode(DataModel.CacheInitParams)
    end
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.CacheInitParams = t
      DataModel.StationId = t.stationId
      DataModel.BuildingId = t.buildingId
      DataModel.NpcId = t.npcId
      DataModel.BgPath = t.bgPath
      DataModel.BgColor = t.bgColor or "FFFFFF"
      DataModel.BgColor = "#" .. DataModel.BgColor
      DataModel.CanSaleList = {}
      DataModel.ShopIdToRecycle = {}
      DataModel.CurTradeType = 0
      DataModel.CurTabType = 0
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
