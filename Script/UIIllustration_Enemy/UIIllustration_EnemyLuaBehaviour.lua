local View = require("UIIllustration_Enemy/UIIllustration_EnemyView")
local DataModel = require("UIIllustration_Enemy/UIIllustration_EnemyDataModel")
local Controller = require("UIIllustration_Enemy/UIIllustration_EnemyController")
local ViewFunction = require("UIIllustration_Enemy/UIIllustration_EnemyViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.self:PlayAnim("Character_in")
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
