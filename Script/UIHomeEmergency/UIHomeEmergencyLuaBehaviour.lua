local View = require("UIHomeEmergency/UIHomeEmergencyView")
local DataModel = require("UIHomeEmergency/UIHomeEmergencyDataModel")
local ViewFunction = require("UIHomeEmergency/UIHomeEmergencyViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.ufid = tostring(Json.decode(initParams).ufid)
      DataModel.furData = PlayerData.ServerData.user_home_info.furniture[DataModel.ufid]
    end
    DataModel.Init()
    DataModel.RefreshRoleListPanel(DataModel.ESortType.level)
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
