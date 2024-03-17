local View = require("UIStoreSkip/UIStoreSkipView")
local DataModel = require("UIStoreSkip/UIStoreSkipDataModel")
local ViewFunction = require("UIStoreSkip/UIStoreSkipViewFunction")
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
