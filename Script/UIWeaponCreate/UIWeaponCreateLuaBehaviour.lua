local View = require("UIWeaponCreate/UIWeaponCreateView")
local DataModel = require("UIWeaponCreate/UIWeaponCreateDataModel")
local ViewFunction = require("UIWeaponCreate/UIWeaponCreateViewFunction")
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    params = initParams
    DataModel.initData(Json.decode(initParams))
    ViewFunction.RefreshPanel()
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
