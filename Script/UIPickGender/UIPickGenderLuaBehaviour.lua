local View = require("UIPickGender/UIPickGenderView")
local DataModel = require("UIPickGender/UIPickGenderDataModel")
local ViewFunction = require("UIPickGender/UIPickGenderViewFunction")
local Controller = require("UIPickGender/UIPickGenderController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller.Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
