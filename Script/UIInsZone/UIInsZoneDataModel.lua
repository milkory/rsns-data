local View = require("UIInsZone/UIInsZoneView")
local DataModel = {
  curLevelIndex = 0,
  nextLevelId = 0,
  chapterId = 0,
  GoBackUI = nil,
  GoBackUIParam = nil
}

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.GoBackUI = data.GoBackUI
  DataModel.GoBackUIParam = data.GoBackUIParam
  DataModel.chapterId = data.chapterId
end

function DataModel.InitData()
  local chapterCA = PlayerData:GetFactoryData(DataModel.chapterId, "ChapterFactory")
  if not chapterCA then
    return
  end
  DataModel.curLevelIndex = DataModel.GetChapterIndex()
end

function DataModel.GetChapterLevelCompleted()
  local chapterCA = PlayerData:GetFactoryData(DataModel.chapterId, "ChapterFactory")
  if not chapterCA then
    return 0
  end
  local count = 0
  for k, v in pairs(chapterCA.stageInfoList) do
    if PlayerData:GetLevelPass(v.levelId) == true then
      count = count + 1
    end
  end
  return count
end

function DataModel.GetChapterIndex()
  local clearedLevelList = PlayerData.ServerData.schedule_chapter and PlayerData.ServerData.schedule_chapter[tostring(DataModel.chapterId)] or {}
  return table.count(clearedLevelList)
end

return DataModel
