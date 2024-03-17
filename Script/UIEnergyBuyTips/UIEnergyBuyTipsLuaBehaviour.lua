local View = require("UIEnergyBuyTips/UIEnergyBuyTipsView")
local DataModel = require("UIEnergyBuyTips/UIEnergyBuyTipsDataModel")
local ViewFunction = require("UIEnergyBuyTips/UIEnergyBuyTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(false)
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
