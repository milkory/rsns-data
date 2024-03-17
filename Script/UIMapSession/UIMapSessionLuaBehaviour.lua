local View = require("UIMapSession/UIMapSessionView")
local DataModel = require("UIMapSession/UIMapSessionDataModel")
local ViewFunction = require("UIMapSession/UIMapSessionViewFunction")
local DataModelController = require("UIMapSession/UIMapSessionDataModelController")
local MapEventController = require("UIMapSession/Controller_MapEventController")
local UIMainUIController = require("UIMainUI/UIMainUIController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local data = Json.decode(initParams)
      DataModelController.Init()
      DataModel.sessionCA = PlayerData:GetFactoryData(data.id, "MapSessionFactory")
      for i, v in pairs(DataModel.sessionCA.mapNeedleList) do
        MapNeedleData.SetChildNeedleData(v.id)
      end
      if GameSetting.runMode ~= "trainSceneDebug" and DataModel.sessionCA.stopTrainAfterInited ~= true then
        UIMainUIController.Stop()
      end
      MapEventController.Init()
      if TrainManager.CurrTrainState ~= TrainState.Stop then
        DataModel.isTrainRunning = true
      elseif DataModel.sessionCA ~= nil then
        DataModel.isTrainRunning = false
        DataModelController.InitSession()
      end
    end
    if DataModel.isOnLeaveInited == true then
      DataModelController.Goback()
      return
    end
    if MapEventController.GetClassMod() ~= nil then
      MapEventController.RecycleCurrent()
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    DataModelController.Update()
    MapEventController.Update()
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
