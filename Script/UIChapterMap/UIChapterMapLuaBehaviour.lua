local View = require("UIChapterMap/UIChapterMapView")
local ViewFunction = require("UIChapterMap/UIChapterMapViewFunction")
local EventListener = require("UIChapterMap/UIChapterMapEventListener")
local DataController = require("UIChapterMap/UIChapterMapDataController")
local UIController = require("UIChapterMap/UIChapterMapUIController")
local DataModel = require("UIChapterMap/UIChapterMapDataModel")
local MapNewDataController = require("UIChapterMap/UIChapterMapNewDataController")
local UIChapterMapLevelChain = require("UIChapterMap/UIChapterMapLevelChain")
local ViewChapter = require("UIChapter/UIChapterView")
local Luabehaviour = {
  deserialize = function(initParams)
    local status = {}
    if initParams ~= nil and initParams ~= "" then
      status = Json.decode(initParams)
    end
    local ca = PlayerData:GetFactoryData(status.chapterId, "ChapterFactory")
    View.self:SetCanvasWidthHeight(1920, 1080)
    View.self:SetToWorldCanvas()
    View.self:ResetMapTransform()
    DataModel.levelList = {}
    DataModel.subLevelList = MapNewDataController.GenSubLevelList(ca)
    local levelList = {}
    local test = MapNewDataController:GenTrackTable(View.Group_Map.Group_Track, nil, nil)
    MapNewDataController:ContactNodes(test, {}, levelList)
    MapNewDataController.ConcatLevel(levelList, ca.stageInfoList, DataModel.levelList)
    UIChapterMapLevelChain.SetLevelChainParams(ca)
    DataController.Deserialize(status, ca)
    DataModel.selectedLevel = DataModel.levelList[status.selectedLevelId]
    DataModel.lastClearedLevel = levelList[1]
    DataController.InitParams(ca)
    DataModel.canOpenLevelChain = UIChapterMapLevelChain.CanUnlockLevelChain(ca)
    ViewChapter.Btn_OpenLevelChain.self:SetActive(DataModel.curState == DataModel.Enum.Normal and DataModel.canOpenLevelChain == true)
    if DataModel.levelChainUnlocked == true then
      MapNewDataController:LevelChainRefresTrackhUI(View.Group_Map.Group_Track.Group_Route1)
      View.Group_Map.Group_LevelChain.self:SetActive(true)
    else
      local levelId
      levelId = PlayerData:GetPlayerPrefs("int", tostring(DataModel.chapterId))
      UIController:RefreshTrackUI(View.Group_Map.Group_Track.Group_Route1, true, true, levelId)
    end
    ViewChapter.Btn_OpenLevelChain.self:SetActive(false)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
