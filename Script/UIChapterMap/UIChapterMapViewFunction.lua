local View = require("UIChapterMap/UIChapterMapView")
local ViewChapter = require("UIChapter/UIChapterView")
local ChapterUIController = require("UIChapter/Model_UIController")
local DataController = require("UIChapterMap/UIChapterMapDataController")
local DataModel = require("UIChapterMap/UIChapterMapDataModel")
local EventListener = require("UIChapterMap/UIChapterMapEventListener")
local ChapterMapLevelChain = require("UIChapterMap/UIChapterMapLevelChain")
local UIChapterController = require("UIChapter/Model_UIController")
local ViewFunction = {
  ChapterMap_Btn_Mask_Click = function(btn, str)
    if ViewChapter.self.IsPlayAnimator == true then
      return
    end
    EventListener:EnableListener()
    if DataModel.selectedLevel == nil then
      return
    end
    DataController:ChangeFocus()
  end,
  Group_Level_Btn_Item_Click = function(btn, str)
    if EventListener.isMouseDrag == true then
      return
    end
    if ViewChapter.self.IsPlayAnimator == true then
      return
    end
    DataModel.selectedLevel = DataModel.levelList[tonumber(str)]
    DataController:ChangeState(true, 0.4, nil)
  end,
  Group_LCLevel_Group_Lock_Start_Btn_Item_Click = function(btn, str)
    EventListener:DisableListener()
    DataModel.selectedLevelChain = View.Group_Map.Group_LevelChain["Group_LevelChain" .. str]
    local chapterCA = PlayerData:GetFactoryData(DataModel.chapterId, "ChapterFactory")
    local levelChainCA = PlayerData:GetFactoryData(chapterCA.levelChainList[tonumber(str)].levelChainId, "LevelChainFactroy")
    UIChapterController.OpenLeveChainInfo(levelChainCA)
  end,
  Group_LCLevel_Group_Lock_End_Btn_Item_Click = function(btn, str)
    EventListener:DisableListener()
    DataModel.selectedLevelChain = View.Group_Map.Group_LevelChain["Group_LevelChain" .. str]
    DataModel.showLevelChainDrops = true
    local chapterCA = PlayerData:GetFactoryData(DataModel.chapterId, "ChapterFactory")
    local levelChainCA = PlayerData:GetFactoryData(chapterCA.levelChainList[tonumber(str)].levelChainId, "LevelChainFactroy")
    UIChapterController.OpenDropDetails(levelChainCA.firstPassAward, levelChainCA.dropList)
  end,
  Group_LClevel_Group_Unlock_Btn_Item_Click = function(btn, str)
    local levelChain = DataModel.LCLevelList[tonumber(str)]
    DataModel.selectedLevel = levelChain
    DataController:ChangeState(true, 0.4, nil)
  end,
  Group_LCLevel_Group_Unlock_Bonus_Btn_Click = function(btn, str)
    local levelChain = DataModel.LCLevelList[tonumber(str)]
    DataModel.selectedLevel = levelChain
    if PlayerData.ServerData.level_chain.buffList[str] == nil then
      PlayerData.ServerData.level_chain.buffList[str] = {}
    end
    ChapterUIController.OpenPanelChooseSkill()
  end,
  Group_LCLevel_Group_Unlock_Finish_Btn_Click = function(btn, str)
    local index = tonumber(str)
    if index == table.count(DataModel.LCLevelList) then
      ChapterMapLevelChain.FinishLevelChain()
    end
  end,
  Group_Security_Group_Normal_Btn_Security_Click = function(btn, str)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local t = {}
    t.stationId = homeConfig.defaultStation
    UIManager:Open("UI/Home/HomeSafe/HomeSafe", Json.encode(t))
  end
}
return ViewFunction
