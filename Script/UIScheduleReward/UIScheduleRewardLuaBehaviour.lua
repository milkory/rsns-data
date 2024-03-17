local View = require("UIScheduleReward/UIScheduleRewardView")
local DataModel = require("UIScheduleReward/UIScheduleRewardDataModel")
local Controller = require("UIScheduleReward/UIScheduleRewardController")
local ViewFunction = require("UIScheduleReward/UIScheduleRewardViewFunction")
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
