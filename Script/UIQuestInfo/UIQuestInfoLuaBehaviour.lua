local View = require("UIQuestInfo/UIQuestInfoView")
local DataModel = require("UIQuestInfo/UIQuestInfoDataModel")
local Controller = require("UIQuestInfo/UIQuestInfoController")
local ViewFunction = require("UIQuestInfo/UIQuestInfoViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.Data = data
    Controller:Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataModel.ClearData()
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
