local View = require("UIMoonthCard/UIMoonthCardView")
local DataModel = require("UIMoonthCard/UIMoonthCardDataModel")
local ViewFunction = require("UIMoonthCard/UIMoonthCardViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Reward.self:SetActive(false)
    View.self:PlayAnim("MonthCardAnim")
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
