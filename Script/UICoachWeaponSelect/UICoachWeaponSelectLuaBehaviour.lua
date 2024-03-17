local View = require("UICoachWeaponSelect/UICoachWeaponSelectView")
local DataModel = require("UICoachWeaponSelect/UICoachWeaponSelectDataModel")
local Controller = require("UICoachWeaponSelect/UICoachWeaponSelectController")
local ViewFunction = require("UICoachWeaponSelect/UICoachWeaponSelectViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.toWeaponPosInfo)
  end,
  deserialize = function(initParams)
    DataModel.toWeaponPosInfo = Json.decode(initParams)
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
