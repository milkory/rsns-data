local View = require("UIBuildWindow/UIBuildWindowView")
local DataModel = require("UIBuildWindow/UIBuildWindowDataModel")
local Controller = require("UIBuildWindow/UIBuildWindowController")
local ViewFunction = require("UIBuildWindow/UIBuildWindowViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller:Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.isBuilding then
      Controller:RefreshBuildTime()
    end
  end,
  ondestroy = function()
    if DataModel.tween then
      DataModel.tween:Kill()
    end
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
