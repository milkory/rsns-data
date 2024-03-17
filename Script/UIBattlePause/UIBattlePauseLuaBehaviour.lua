local View = require("UIBattlePause/UIBattlePauseView")
local DataModel = require("UIBattlePause/UIBattlePauseDataModel")
local ViewFunction = require("UIBattlePause/UIBattlePauseViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
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
