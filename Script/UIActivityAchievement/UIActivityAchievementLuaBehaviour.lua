local View = require("UIActivityAchievement/UIActivityAchievementView")
local DataModel = require("UIActivityAchievement/UIActivityAchievementDataModel")
local ViewFunction = require("UIActivityAchievement/UIActivityAchievementViewFunction")
local Controller = require("UIActivityMain/BlackTeaActivityController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.InitData()
    Controller.RefreshAchieve(DataModel.defaultType)
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
