local View = require("UIOilUpWindow/UIOilUpWindowView")
local DataModel = require("UIOilUpWindow/UIOilUpWindowDataModel")
local Controller = require("UIOilUpWindow/UIOilUpWindowController")
local ViewFunction = require("UIOilUpWindow/UIOilUpWindowViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.Info = Json.decode(initParams)
    DataModel.IsOutAnim = false
    Controller:Init()
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
