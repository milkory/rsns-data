local DataModel = require("UIMapSession/UIMapSessionDataModel")
local MapEvenetController = require("UIMapSession/Controller_MapEventController")
local View = require("UIMapSession/UIMapSessionView")
local UIMainUIController = require("UIMainUI/UIMainUIController")
local DataModelController = {}
local AfterOnEnter = function()
  View.Group_CommonTopLeft.Btn_Return:SetActive(true)
  MapSessionManager:SessionOnEnd()
end

function DataModelController.Init()
  DataModel.sessionCA = nil
  DataModel.isUpdating = false
  DataModel.isTrainRunning = false
  DataModel.isOnInitInited = false
  DataModel.isOnEnterInited = false
  DataModel.isOnLeaveInited = false
end

function DataModelController.InitSession()
  if DataModel.sessionCA ~= nil then
    local ca = DataModel.sessionCA
    if DataModel.isOnInitInited ~= true and DataModel.sessionCA.onInitId ~= nil and DataModel.sessionCA.onInitId > 0 then
      DataModel.isOnInitInited = true
      local continueCamera = MapEvenetController.InitEvent(nil, DataModel.sessionCA.onInitId, DataModel.sessionCA.onInitArgs)
      if continueCamera then
        View.Group_CommonTopLeft.Btn_Return:SetActive(false)
        MapSessionManager:MoveTo(DataModelController.OnCompleted)
        if ca.cameraUseTween == true then
          DataModel.isUpdating = true
        end
      end
    elseif DataModel.isTrainRunning == true then
      UIMainUIController.Stop()
    else
      View.Group_CommonTopLeft.Btn_Return:SetActive(false)
      MapSessionManager:MoveTo(DataModelController.OnCompleted)
      if ca.cameraUseTween == true then
        DataModel.isUpdating = true
      end
    end
  end
end

function DataModelController.Update()
  if DataModel.isTrainRunning == true and (TrainManager.CurrTrainState == TrainState.Stop or TrainManager.CurrTrainState == TrainState.None) then
    DataModel.isTrainRunning = false
    DataModelController.InitSession()
  end
  if DataModel.isOnInitInited == true and DataModel.executeMove == true then
    DataModel.executeMove = false
    View.Group_CommonTopLeft.Btn_Return:SetActive(false)
    MapSessionManager:MoveTo(DataModelController.OnCompleted)
    if DataModel.sessionCA.cameraUseTween == true then
      DataModel.isUpdating = true
    end
  end
  if UIManager:IsPanelOpened("UI/Dialog/Dialog") then
    if View.Group_CommonTopLeft.Btn_Return.IsActive then
      View.Group_CommonTopLeft.Btn_Return:SetActive(false)
    end
  elseif not View.Group_CommonTopLeft.Btn_Return.IsActive then
    View.Group_CommonTopLeft.Btn_Return:SetActive(true)
  end
end

function DataModelController.Destroy()
end

function DataModelController.OnCompleted()
  DataModel.isUpdating = false
  MapSessionManager:EnableSessionCameraInput(true, DataModel.sessionCA.rotationMinX, DataModel.sessionCA.rotationMaxX, DataModel.sessionCA.rotationMinY, DataModel.sessionCA.rotationMaxY)
  AfterOnEnter()
end

function DataModelController.OnLeave()
  DataModel.isOnLeaveInited = true
  return MapEvenetController.InitEvent(nil, DataModel.sessionCA.onLeaveId, DataModel.sessionCA.onLeaveArgs)
end

function DataModelController.Goback()
  for i, v in pairs(DataModel.sessionCA.mapNeedleList) do
    MapNeedleData.SetChildNeedleData(v.id, true)
  end
  DataModel.sessionCA = nil
  MapSessionManager:Goback()
end

function DataModelController.SetFlag(id)
  Net:SendProto("adventure.set_flag", function(json)
    MapSessionManager:SetGroupMsg(json)
  end, id)
end

function DataModelController.GetGroup(groupId)
  Net:SendProto("adventure.get_group", function(json)
    MapSessionManager:SetGroupMsg(json.map_event[groupId])
  end, groupId)
end

function DataModelController.ExitToSession()
  if PlayerData.BattleInfo.BattleResult and PlayerData.BattleInfo.BattleResult.isWin and PlayerData.BattleInfo.battleStageId and DataModel.sessionCA and DataModel.sessionCA.needWinlevel and DataModel.sessionCA.needWinlevel == tonumber(PlayerData.BattleInfo.battleStageId) then
    MapSessionManager:ExitToSession(DataModel.sessionCA.onLevelWinOpenSession)
  end
end

return DataModelController
