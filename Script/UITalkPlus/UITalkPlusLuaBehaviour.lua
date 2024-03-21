local View = require("UITalkPlus/UITalkPlusView")
local DataModel = require("UITalkPlus/UITalkPlusDataModel")
local Controller = require("UITalkPlus/UITalkPlusController")
local ViewFunction = require("UITalkPlus/UITalkPlusViewFunction")
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
    Controller:CloseView()
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
