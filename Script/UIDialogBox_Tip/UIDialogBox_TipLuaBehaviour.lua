local View = require("UIDialogBox_Tip/UIDialogBox_TipView")
local DataModel = require("UIDialogBox_Tip/UIDialogBox_TipDataModel")
local ViewFunction = require("UIDialogBox_Tip/UIDialogBox_TipViewFunction")
local Controller = require("UIDialogBox_Tip/UIDialogBox_Controller")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local json = Json.decode(initParams)
    DataModel.TextId = json.levelTextId
    DataModel.Params = json.params
    DataModel.FacePath = json.facePath
    DataModel.CurrTime = nil
    DataModel.IsSuccess = json.isSuccess
    DataModel.IsUpdate = true
    DataModel.EventId = json.eventId
    DataModel.IsClosing = false
    DataModel.IsDestroy = false
    View.self:PlayAnim("DialogBox_in")
    Controller.Init(Json.decode(initParams))
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if not DataModel.IsUpdate or DataModel.IsDestroy or DataModel.IsClosing then
      return
    end
    if not DataModel.IsSuccess then
      if DataModel.CurrTime == nil then
        DataModel.CurrTime = Time.time
      end
      if Time.time - DataModel.CurrTime > 3 then
        Controller.Close()
      end
    else
      local strike = PlayerData.GetStrike()
      local strikeCfg = PlayerData:GetFactoryData(strike.id)
      local ratioA = strikeCfg.configWinPercent
      local currPower = TrainManager.CurrSpeed + strikeCfg.power
      local eventCfg = PlayerData:GetFactoryData(DataModel.EventId)
      local successRatio = (ratioA + (currPower - eventCfg.hp) / eventCfg.hp) * strikeCfg.percentWin
      successRatio = math.min(99, math.max(1, math.floor(successRatio * 100)))
      Controller.Update(Time.time, successRatio)
    end
  end,
  ondestroy = function()
    DataModel.CurrTime = nil
    DataModel.IsDestroy = true
  end,
  enable = function()
    DataModel.CurrTime = nil
  end,
  disenable = function()
    DataModel.CurrTime = nil
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
