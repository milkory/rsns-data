local View = require("UIBroadCast/UIBroadCastView")
local DataModel = require("UIBroadCast/UIBroadCastDataModel")
local ViewFunction = require("UIBroadCast/UIBroadCastViewFunction")
local Controller = require("UIBroadCast/UIBroadCastController")
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
    Controller:UpdateView()
  end,
  ondestroy = function()
  end,
  enable = function()
    Controller:InitView()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
