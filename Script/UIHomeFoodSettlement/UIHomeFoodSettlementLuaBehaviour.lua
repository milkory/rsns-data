local View = require("UIHomeFoodSettlement/UIHomeFoodSettlementView")
local DataModel = require("UIHomeFoodSettlement/UIHomeFoodSettlementDataModel")
local ViewFunction = require("UIHomeFoodSettlement/UIHomeFoodSettlementViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    local bgNum = View.Img_BGNum
    bgNum.Group_Before.Txt_Num:SetText(param.lastHomeEnergy)
    bgNum.Txt_After:SetText(param.curEnergy)
    View.Txt_Tip:SetText(string.format(GetText(80601346), math.min(param.foodEnergy, param.lastHomeEnergy)))
    DataModel.hid = param.hid
    DataModel.mealId = param.mealId
    DataModel.isOutSide = param.isOutside
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
