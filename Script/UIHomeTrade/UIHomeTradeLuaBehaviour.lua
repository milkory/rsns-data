local View = require("UIHomeTrade/UIHomeTradeView")
local DataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local TradeDataModel = require("UIHomeTrade/UITradeDataModel")
local Controller = require("UIHomeTrade/UIHomeTradeController")
local ViewFunction = require("UIHomeTrade/UIHomeTradeViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {}
    t.goBackIn = true
    t.isTradeOpen = DataModel.IsTradeOpen
    t.stationId = DataModel.StationId
    t.npcId = DataModel.NpcId
    t.bgPath = DataModel.BgPath
    t.bgColor = DataModel.bgColor or "FFFFFF"
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.StationId = t.stationId
      DataModel.NpcId = t.npcId
      DataModel.BgPath = t.bgPath
      DataModel.bgColor = t.bgColor or "FFFFFF"
      DataModel.BgColor = "#" .. DataModel.bgColor
      TradeDataModel.StationId = t.stationId
      if t.goBackIn then
        Controller:BackInit()
        if t.isTradeOpen then
          UIManager:LoadSplitPrefab(View, "UI/HomeTrade/HomeTrade", "Group_Trade")
          View.Group_Trade.self:SetActive(true)
          local TradeController = require("UIHomeTrade/UITradeController")
          View.Group_Trade.Group_Bargain.Group_Success.self:SetActive(false)
          View.Group_Trade.Group_Bargain.Group_Success2.self:SetActive(false)
          View.Group_Trade.Group_Bargain.Group_Fail.self:SetActive(false)
          TradeController:RefreshResources()
          TradeController:RefreshTradePanelByType(nil, true, true)
          View.self:PlayAnim("Trade")
        end
      else
        PlayerData.TempCache.NPCTalkData = {}
        Controller:ShowInitView()
      end
      local showRed = false
      local cfg = PlayerData:GetFactoryData(80300339, "ListFactory")
      local noteBookDataModel = require("UINotebook/UINotebookDataModel")
      for i, v in pairs(cfg.dataTab) do
        if v.id == 80301384 then
          showRed = noteBookDataModel.GetNewNum(v) > 0
          break
        end
      end
      View.Group_CommonTopLeft.Btn_.Img_RemindOut:SetActive(showRed)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    local TradeController = require("UIHomeTrade/UITradeController")
    TradeController:ShowQuestInfoChild(false)
    TradeDataModel.ClearData()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
