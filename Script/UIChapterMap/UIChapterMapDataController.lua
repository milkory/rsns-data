local View = require("UIChapterMap/UIChapterMapView")
local ViewChapter = require("UIChapter/UIChapterView")
local DataModel = require("UIChapterMap/UIChapterMapDataModel")
local ChapterUIController = require("UIChapter/Model_UIController")
local EventListener = require("UIChapterMap/UIChapterMapEventListener")
local Focus = {
  constZAxis = 1400,
  RefreshUI = function(self)
    DataModel.selectedLevel.Group_Normal.self:SetActive(false)
    if DataModel.selectedLevel.data.isSpecialLevel ~= true then
      View.Group_Map.Group_LevelEffect.self.transform:SetParent(DataModel.selectedLevel.self.transform)
      View.Group_Map.Group_LevelEffect.self:SetLocalPosition(Vector3(0, 0, 0))
      View.Group_Map.Group_LevelEffect.self:SetActive(true)
      View.Group_Map.Group_LevelEffect.Txt_ChapterIndex:SetText(DataModel.selectedLevel.data.chapterIdxDes)
      View.Group_Map.Group_LevelEffect.Txt_LevelSid:SetText(DataModel.selectedLevel.data.idxDes)
      local bossId = PlayerData:GetFactoryData(DataModel.selectedLevel.data.levelId, "LevelFactory").bossId
      local hasBoss = bossId ~= nil and 0 < bossId
      View.Group_Map.Group_LevelEffect.Spine_Mark:SetActive(hasBoss)
      View.Group_Map.Group_LevelEffect.Img_Mark:SetActive(not hasBoss)
    else
      DataModel.selectedLevel.Group_LevelEffect.self:SetActive(true)
    end
    ChapterUIController:Refresh(DataModel.selectedLevel.data.levelId, DataModel.selectedLevel.data.type == "Group_LCLevel")
    ChapterUIController.PlayAniChapterBig()
  end,
  RefreshPosition = function(self, useTween, tweenTime, callback)
    local offsetX = ViewChapter.Group_SecondPanel.Group_Right.Img_Bottom.Rect.sizeDelta.x / 3
    View.Group_Map.self:Center(DataModel.selectedLevel.self.transform, View.camera, useTween, tweenTime, callback, offsetX, self.constZAxis)
  end
}
local Normal = {
  constZAxis = 1800,
  RefreshUI = function(self)
    View.Group_Map.Group_LevelEffect.self:SetActive(false)
    if DataModel.selectedLevel ~= nil then
      DataModel.selectedLevel.Group_Normal.self:SetActive(true)
      if DataModel.selectedLevel.data.isSpecialLevel == true then
        DataModel.selectedLevel.Group_LevelEffect.self:SetActive(false)
      end
    end
  end,
  RefreshPosition = function(self)
    View.Group_Map.self.transform.position = DataModel.curMapPosition
  end,
  RefreshPositionOnClick = function(self, useTween, tweenTime, callback)
    local newPos = Vector3(DataModel.curMapPosition.x, DataModel.curMapPosition.y, self.constZAxis)
    View.Group_Map.self:SetPos(newPos, useTween, tweenTime, callback)
    DataModel.curMapPosition = newPos
  end
}
local module = {
  View = View,
  Serialize = function()
    local status = {}
    status.chapterId = DataModel.chapterId
    status.curState = DataModel.curState
    if DataModel.selectedLevel ~= nil then
      status.selectedLevelId = DataModel.selectedLevel.data.levelId
    end
    return status
  end,
  Deserialize = function(status, ca)
    if status == nil then
      return
    end
    DataModel.chapterId = status.chapterId
    DataModel.curState = status.curState
    DataModel.chapterAbbreviate = ca.abbreviate
    DataModel.Edge.top = ca.top
    DataModel.Edge.bottom = ca.bottom
    DataModel.Edge.left = ca.left
    DataModel.Edge.right = ca.right
    local unlock = PlayerData:GetPlayerPrefs("int", "LevelChain" .. DataModel.chapterId)
    DataModel.levelChainUnlocked = unlock == 1 and true or false
  end,
  OnDestroy = function()
    Normal:RefreshUI()
    View.Group_Map.Group_LevelEffect.self.transform:SetParent(View.Group_Map.self.transform)
    if DataModel.curMapPosition ~= nil and PlayerData.LevelChain.OnLevelChain ~= true then
      DataModel.chapterPosList[DataModel.chapterId] = DataModel.curMapPosition
    end
    DataModel.chapterId = nil
    DataModel.selectedLevel = nil
    DataModel.curMapPosition = nil
    DataModel.curState = nil
    DataModel.chapterIndex = nil
    DataModel.lastClearedLevel = nil
    DataModel.levelList = {}
    DataModel.canOpenLevelChain = nil
    DataModel.levelChainUnlocked = nil
    DataModel.showLevelChainDrops = nil
  end
}

function module:ChangeState(useTween, tweenTime, callback)
  if DataModel.curState == DataModel.Enum.Normal then
    DataModel.curState = DataModel.Enum.Focus
    EventListener:DisableListener()
    View.Btn_Mask:SetActive(true)
    Focus:RefreshUI()
    Focus:RefreshPosition(useTween, tweenTime, callback)
  else
    DataModel.curState = DataModel.Enum.Normal
    Normal:RefreshUI()
    Normal:RefreshPositionOnClick(useTween, tweenTime, callback)
  end
end

function module.Center(level, useTween, tweenTime, callback)
  View.Group_Map.self:Center(level.self.transform, View.camera, useTween, tweenTime, callback, 0, Normal.constZAxis)
end

function module.InitParams(ca)
  View.self:PlayAnim("In")
  if DataModel.chapterPosList[DataModel.chapterId] ~= nil then
    local pos = DataModel.chapterPosList[DataModel.chapterId]
    DataModel.curMapPosition = Vector3(pos.x, pos.y, Normal.constZAxis)
  else
    local firstLevel = DataModel.levelList[ca.stageInfoList[1].levelId]
    View.Group_Map.self:Center(firstLevel.self.transform, View.camera, false, 0, nil, 500, Normal.constZAxis)
    DataModel.curMapPosition = View.Group_Map.transform.position
    DataModel.chapterPosList[DataModel.chapterId] = DataModel.curMapPosition
  end
  EventListener.SetupMapTransform()
  if DataModel.curState == DataModel.Enum.Focus then
    EventListener:DisableListener()
    View.Btn_Mask:SetActive(true)
    Focus:RefreshUI()
    Focus:RefreshPosition(false, 0, nil)
    return
  end
  EventListener:EnableListener()
  DataModel.curState = DataModel.Enum.Normal
  View.Btn_Mask:SetActive(false)
  Normal:RefreshUI()
  Normal:RefreshPosition()
end

function module.SetLevelBeforeStartBattle()
  if PlayerData:GetLevelPass(DataModel.selectedLevel.data.levelId) == false then
    PlayerData:SetPlayerPrefs("int", tostring(DataModel.chapterId), DataModel.selectedLevel.data.levelId)
  end
end

function module.GetChapterId()
  return DataModel.chapterId
end

function module:ChangeFocus()
  if DataModel.curState == DataModel.Enum.Focus then
    ChapterUIController.PlayAniChapterSmall()
    self:ChangeState(true, 0.4, nil)
    View.Btn_Mask:SetActive(false)
    ViewChapter.Btn_OpenLevelChain.self:SetActive(false)
    return true
  end
  return false
end

function module.OpenLevelChain()
  View.Group_Map.Group_LevelChain.self:SetActive(true)
end

return module
