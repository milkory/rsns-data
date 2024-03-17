local View = require("UICommonChangeScene/UICommonChangeSceneView")
local DataModel = require("UICommonChangeScene/UICommonChangeSceneDataModel")
local ViewFunction = require("UICommonChangeScene/UICommonChangeSceneViewFunction")
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
