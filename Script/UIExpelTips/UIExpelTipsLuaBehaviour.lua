local View = require("UIExpelTips/UIExpelTipsView")
local DataModel = require("UIExpelTips/UIExpelTipsDataModel")
local ViewFunction = require("UIExpelTips/UIExpelTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    View.Txt_Name:SetText(info.seriesName)
    View.Group_Deterrence.Txt_Num:SetText("+" .. info.deterrence)
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
