local UIController = require("UIChapterSelect/UIAssessment/UIAssessmentUIController")
local DataModel = require("UIChapterSelect/UIAssessment/UIAssessmentDataModel")
local GridController = require("UIChapterSelect/UIAssessment/UIAssessmentGridController")
local module = {}

function module:Deserialize()
  DataModel.chapterList = PlayerData:GetFactoryData(99900001, "ConfigFactory").collegeChapter
  local selectedChapterId = DataModel.chapterList[DataModel.selectedChapterIndex].chapterId
  DataModel.levelList = self.GetUnlockedLevels(selectedChapterId)
  DataModel.selectedLevelIndex = self.FindLastClearedLevelOrDefault(DataModel.levelList)
  GridController:RefreshAll()
  UIController:RefreshAll()
end

function module.OnDestroy()
  DataModel.chapterList = {}
  DataModel.levelList = {}
  DataModel.selectedChapterIndex = 1
  DataModel.selectedLevelIndex = 1
end

function module.GetUnlockedLevels(selectedChapterId)
  local levelIdList = {}
  local caLevelList = PlayerData:GetFactoryData(selectedChapterId, "ChapterFactory").stageInfoList
  for i = 1, table.count(caLevelList) do
    local levelPassed = LevelCheck.CheckPreLevel(caLevelList[i].levelId)
    if levelPassed == true then
      table.insert(levelIdList, caLevelList[i])
    end
  end
  return levelIdList
end

function module.FindLastClearedLevelOrDefault(levelList)
  local listCount = table.count(levelList)
  if 2 <= listCount then
    for i = listCount, 2 do
      local levelId = levelList[i].levelId
      if PlayerData:GetLevelPass(levelId) == true then
        return i
      end
    end
  end
  return 1
end

return module
