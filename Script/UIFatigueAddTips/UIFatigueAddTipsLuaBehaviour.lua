local View = require("UIFatigueAddTips/UIFatigueAddTipsView")
local DataModel = require("UIFatigueAddTips/UIFatigueAddTipsDataModel")
local ViewFunction = require("UIFatigueAddTips/UIFatigueAddTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Fatigue = tonumber(initParams)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local homeCommon = require("Common/HomeCommon")
    local maxEnergy = homeCommon.GetMaxHomeEnergy()
    local before = PlayerData:GetUserInfo().move_energy - DataModel.Fatigue
    View.Group_Bar.Img_Bar1:SetFilledImgAmount(math.min(1, before / maxEnergy))
    View.Group_Bar.Img_Bar2:SetFilledImgAmount(math.min(1, PlayerData:GetUserInfo().move_energy / maxEnergy))
    View.Group_Value.Txt_C:SetText(before)
    View.Group_Value.Txt_All:SetText(maxEnergy)
    View.Group_Value.Txt_Add:SetText(DataModel.Fatigue)
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
