local View = require("UIDataTips/UIDataTipsView")
local DataModel = require("UIDataTips/UIDataTipsDataModel")
local ViewFunction = require("UIDataTips/UIDataTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.self:PlayAnimOnce("in_out", function()
      UIManager:GoBack(false)
    end)
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
