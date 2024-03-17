local View = require("UICommonSkip/UICommonSkipView")
local DataModel = require("UICommonSkip/UICommonSkipDataModel")
local ViewFunction = require("UICommonSkip/UICommonSkipViewFunction")
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
