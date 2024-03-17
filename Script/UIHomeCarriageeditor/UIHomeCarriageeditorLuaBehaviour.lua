local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local EditDataModel = require("UIHomeCarriageeditor/UIEditDataModel")
local RefitDataModel = require("UIHomeCarriageeditor/UIRefitDataModel")
local Controller = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local EditController = require("UIHomeCarriageeditor/UIEditController")
local ViewFunction = require("UIHomeCarriageeditor/UIHomeCarriageeditorViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {}
    t.CurrTag = DataModel.curSelectIdx
    t.ChildTag = DataModel.ChildTag
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    DataModel.curSelectIdx = 0
    if initParams then
      local t = Json.decode(initParams)
      DataModel.CurrTag = t.CurrTag
      DataModel.ChildTag = t.ChildTag
    else
      DataModel.CurrTag = DataModel.TagType.Fix
      DataModel.ChildTag = nil
    end
    EditDataModel.isBuilding = false
    EditDataModel.isEditMode = false
    DataModel.isTrainMoved = false
    DataModel.TimeLineId = 0
    DataModel.TimeLineSound = nil
    DataModel.NeedRemoveScene = false
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    if HomeCoachFactoryManager:GetCurSceneName() == homeConfig.TrainFactoryScenes then
      DataModel.FirstFrame = true
      local isHaveCoach = false
      if HomeTrainManager.trainTran ~= nil and 0 < HomeTrainManager.trainTran.childCount then
        isHaveCoach = true
      end
      if MainManager.bgSceneName == "Home" or not isHaveCoach then
        DataModel.NeedRemoveScene = true
        if MainManager.bgSceneName == "Home" then
          HomeTrainManager.trainTran = CS.UnityEngine.GameObject.Find("FactoryTrain").transform
        end
        local skinIds = {}
        for i, v in pairs(PlayerData:GetHomeInfo().coach) do
          local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
          local skinId = tonumber(v.skin)
          if skinId == nil then
            skinId = coachCA.defaultSkin
          end
          table.insert(skinIds, skinId)
        end
        HomeTrainManager:LoadTrains(skinIds, 0)
      end
      HomeCoachFactoryManager:SetTrain()
      Controller:Init()
    end
    TrainManager:SetHuoInternalCheLeight(false)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.FirstFrame then
      DataModel.FirstFrame = false
      local camera = TrainCameraManager:GetCamera(4)
      if camera ~= nil and not camera:IsNull() then
        local transform = camera.gameObject.transform
        local pos = transform.localPosition
        pos.x = 10000
        transform.localPosition = pos
      end
    end
    local down = false
    if Input.GetMouseButton(0) then
      down = true
    end
    DataModel.curFrameMouseDown = false
    DataModel.curFrameMouseUp = false
    if DataModel.preMouseDown ~= down then
      if DataModel.preMouseDown == false then
        DataModel.curFrameMouseDown = true
      else
        DataModel.curFrameMouseUp = true
      end
    end
    DataModel.preMouseDown = down
    if DataModel.curSelectIdx == DataModel.TagType.Edit then
      if EditDataModel.isEditMode then
        if DataModel.curFrameMouseUp then
          EditDataModel.isDrag = false
        end
        if EditDataModel.isDrag then
          local pos = Input.mousePosition
          View.Group_TempTrain.self:SetAnchoredPosition(Vector2(pos.x, pos.y))
          EditController:Draging()
        end
        if not EditDataModel.isDrag and View.Group_TempTrain.self.IsActive then
          EditController:DragEnd()
        end
      end
      if EditDataModel.isBuilding then
        EditController:RefreshBuildTimeShow()
      end
    end
  end,
  ondestroy = function()
    if DataModel.curSelectIdx == DataModel.TagType.Skin then
      local skinController = require("UIHomeCarriageeditor/UITrainSkinController")
      skinController:ExitTrainSkin()
    end
    RefitDataModel.ClearCacheObject()
    HomeCoachFactoryManager:Recycle()
    Controller:RemoveCurTimeLine()
    if DataModel.TimeLineSound then
      DataModel.TimeLineSound:Recycle()
      DataModel.TimeLineSound = nil
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
