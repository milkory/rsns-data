local View = require("UIEngineCore/UIEngineCoreView")
local DataModel = require("UIEngineCore/UIEngineCoreDataModel")
local Controller = require("UIEngineCore/UIEngineCoreController")
local ViewFunction = require("UIEngineCore/UIEngineCoreViewFunction")
local Luabehaviour = {
  serialize = function()
    if DataModel.Data == nil then
      DataModel.Data = {}
    end
    DataModel.Data.autoClickCoreType = DataModel.CurEngineCoreType
    return Json.encode(DataModel.Data)
  end,
  deserialize = function(initParams)
    DataModel.Data = nil
    if initParams then
      DataModel.Data = Json.decode(initParams)
    end
    Controller:Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    Controller:DraggingAnim()
  end,
  ondestroy = function()
    if DataModel.BreakEffectObj ~= nil then
      Object.Destroy(DataModel.BreakEffectObj)
    end
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
