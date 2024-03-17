local View = require("UIGroup_TrainWeaponSth/UIGroup_TrainWeaponSthView")
local DataModel = require("UIGroup_TrainWeaponSth/UIGroup_TrainWeaponSthDataModel")
local ViewFunction = require("UIGroup_TrainWeaponSth/UIGroup_TrainWeaponSthViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local uid = Json.decode(initParams).uid
    print_r(PlayerData:GetBattery())
    DataModel.initData(uid)
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
