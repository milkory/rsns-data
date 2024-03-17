local View = require("UIRubbishStation/UIRubbishStationView")
local DataModel = require("UIRubbishStation/UIRubbishStationDataModel")
local ViewFunction = require("UIRubbishStation/UIRubbishStationViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode({
      isRecyclePanel = DataModel.isRecyclePanel,
      isCityMapIn = DataModel.isCityMapIn,
      buildingId = DataModel.buildingId
    })
  end,
  deserialize = function(initParams)
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
