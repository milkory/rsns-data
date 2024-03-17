local View = require("UIIllustration_Character/UIIllustration_CharacterView")
local DataModel = require("UIIllustration_Character/UIIllustration_CharacterDataModel")
local Controller = require("UIIllustration_Character/UIIllustration_CharacterController")
local ViewFunction = require("UIIllustration_Character/UIIllustration_CharacterViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.self:PlayAnim("Enemy_in")
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
