local View = require("UIFlierMain/UIFlierMainView")
local DataModel = require("UIFlierMain/UIFlierMainDataModel")
local ViewFunction = require("UIFlierMain/UIFlierMainViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local info = Json.decode(initParams)
      DataModel.StationId = info.StationId
      DataModel.OnShowRefresh()
    end
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
