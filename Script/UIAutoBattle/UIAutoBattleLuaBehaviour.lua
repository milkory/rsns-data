local View = require("UIAutoBattle/UIAutoBattleView")
local DataModel = require("UIAutoBattle/UIAutoBattleDataModel")
local ViewFunction = require("UIAutoBattle/UIAutoBattleViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.IsChanged = false
    ViewFunction:RefreshAll()
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
