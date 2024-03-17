local View = require("UIPayTips/UIPayTipsView")
local DataModel = require("UIPayTips/UIPayTipsDataModel")
local Controller = require("UIPayTips/UIPayTipsController")
local ViewFunction = require("UIPayTips/UIPayTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Debug.Log("[Pay]UIPayTips Open")
    DataModel:SetData(Json.decode(initParams))
    Controller:InitView()
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
