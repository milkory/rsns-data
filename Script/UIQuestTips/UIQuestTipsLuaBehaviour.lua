local View = require("UIQuestTips/UIQuestTipsView")
local DataModel = require("UIQuestTips/UIQuestTipsDataModel")
local Controller = require("UIQuestTips/UIQuestTipsController")
local ViewFunction = require("UIQuestTips/UIQuestTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.questInfo = Json.decode(initParams)
    DataModel.count = #DataModel.questInfo
    Controller:Show()
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
