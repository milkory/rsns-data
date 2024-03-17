local View = require("UIHomeElectric/UIHomeElectricView")
local DataModel = require("UIHomeElectric/UIHomeElectricDataModel")
local Controller = require("UIHomeElectric/UIHomeElectricController")
local ViewFunction = require("UIHomeElectric/UIHomeElectricViewFunction")
local Luabehaviour = {
  serialize = function()
    local data = {}
    data.curSelectType = DataModel.curSelectType
    return Json.encode(data)
  end,
  deserialize = function(initParams)
    DataModel.data = nil
    if initParams then
      DataModel.data = Json.decode(initParams)
      DataModel.curSelectType = DataModel.data.curSelectType or 1
    else
      DataModel.curSelectType = 1
    end
    DataModel.InitData()
    DataModel.InitSlotLvRecord()
    Controller:Init()
    if DataModel.data and DataModel.data.autoClickCoreType then
      local t = {}
      t.autoClickCoreType = DataModel.data.autoClickCoreType
      UIManager:Open("UI/EngineCore/EngineCore", Json.encode(t))
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    Controller:OnDisable()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
