local View = require("UIFlier_Magazine/UIFlier_MagazineView")
local DataModel = require("UIFlier_Magazine/UIFlier_MagazineDataModel")
local ViewFunction = require("UIFlier_Magazine/UIFlier_MagazineViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local info = Json.decode(initParams)
      DataModel.StationId = info.stationId
    end
    DataModel.OnShowRefresh()
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    if PosClickHandler.GetCoachDirtyPercent() < homeConfig.cleantwo then
      CommonTips.OpenFlierConditionTips({
        showType = EnumDefine.FlierConditionShowType.showNeedClean,
        stationId = DataModel.stationId
      })
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
