local View = require("UICancelTips/UICancelTipsView")
local DataModel = require("UICancelTips/UICancelTipsDataModel")
local ViewFunction = require("UICancelTips/UICancelTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.key = data.key
    DataModel.value = data.value
    View.Group_Dec.Txt_Num:SetText(DataModel.value)
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
