local View = require("UIBuffTips/UIBuffTipsView")
local DataModel = require("UIBuffTips/UIBuffTipsDataModel")
local ViewFunction = require("UIBuffTips/UIBuffTipsViewFunction")
local Controller = require("UIActivityMain/BlackTeaActivityController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.InitData()
    Controller.RefreshBuffStage()
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
