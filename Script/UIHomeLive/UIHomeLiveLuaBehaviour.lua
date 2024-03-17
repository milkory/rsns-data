local View = require("UIHomeLive/UIHomeLiveView")
local DataModel = require("UIHomeLive/UIHomeLiveDataModel")
local Controller = require("UIHomeLive/UIHomeLiveController")
local ViewFunction = require("UIHomeLive/UIHomeLiveViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.curUfid = initParams
    Controller:Init()
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
