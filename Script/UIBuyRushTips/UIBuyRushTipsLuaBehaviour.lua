local View = require("UIBuyRushTips/UIBuyRushTipsView")
local DataModel = require("UIBuyRushTips/UIBuyRushTipsDataModel")
local ViewFunction = require("UIBuyRushTips/UIBuyRushTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local cfg = PlayerData:GetFactoryData("99900007")
    local max = PlayerData.GetMaxFuelNum()
    View.Group_Tip.Btn_Tip.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoAddRush") == 1)
    DataModel.maxNum = max - PlayerData:GetHomeInfo().readiness.fuel.fuel_num
    DataModel.currentNum = 1
    View.Group_Item.Txt_Num:SetText(PlayerData:GetHomeInfo().readiness.fuel.fuel_num)
    DataModel.CostItem = cfg.trainRushBuyList
    View.Group_Slider.Slider_Value:SetMinAndMaxValue(DataModel.currentNum, DataModel.maxNum)
    DataModel:SetNum(DataModel.maxNum)
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
