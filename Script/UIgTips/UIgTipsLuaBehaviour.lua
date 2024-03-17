local View = require("UIgTips/UIgTipsView")
local DataModel = require("UIgTips/UIgTipsDataModel")
local ViewFunction = require("UIgTips/UIgTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
