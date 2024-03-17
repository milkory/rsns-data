local DataModel = require("UIChapterSelect/UIChapterSelectDataModel")
local AssessmentDataController = require("UIChapterSelect/UIAssessment/UIAssessmentDataController")
local module = {}

function module:Serialize()
  local dataModel = {}
  dataModel.selectedIndex = DataModel.selectedIndex
  return dataModel
end

function module:OnDestroy()
  PlayerData:SetPlayerPrefs("int", "ChapterIndex", DataModel.selectedIndex)
  AssessmentDataController.OnDestroy()
end

function module:GetUnlockChapter()
  local index = 1
  for i, v in ipairs(PlayerData.ChapterData.SortChapter) do
    index = i
    local lastLevel = v.levelList[v.levelList.count]
    local serverData = PlayerData.ServerData.chapter_level[tostring(lastLevel)]
    if serverData and serverData.score >= 0 then
    else
      break
    end
  end
  index = index > #PlayerData.ChapterData.SortChapter and #PlayerData.ChapterData.SortChapter or index
  return index
end

return module
