local View = require("UIGroup_InvestTip/UIGroup_InvestTipView")
local DataModel = require("UIGroup_InvestTip/UIGroup_InvestTipDataModel")
local ViewFunction = require("UIGroup_InvestTip/UIGroup_InvestTipViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.SetJsonData(initParams)
    DataModel.RefreshOnShow()
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
