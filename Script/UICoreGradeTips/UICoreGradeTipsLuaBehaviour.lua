local View = require("UICoreGradeTips/UICoreGradeTipsView")
local DataModel = require("UICoreGradeTips/UICoreGradeTipsDataModel")
local Controller = require("UICoreGradeTips/UICoreGradeTipsController")
local ViewFunction = require("UICoreGradeTips/UICoreGradeTipsViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.data)
  end,
  deserialize = function(initParams)
    DataModel.data = Json.decode(initParams)
    Controller:Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataModel.curSelectIdx = -1
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
