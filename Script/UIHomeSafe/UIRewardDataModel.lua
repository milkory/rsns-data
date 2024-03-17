local MainDataModel = require("UIHomeSafe/UIHomeSafeDataModel")
local DataModel = {
  rewardLevels = {},
  recordAllRewardLevelInfo = {},
  CurRepInfo = {},
  IsShowEmpty = false,
  CurSelectIdx = 0,
  StarBgPath = "UI/Home/HomeSafe/bg_%s",
  EnemyBgPath = "UI/Home/HomeSafe/name_%s",
  CurShowDrop = {},
  NextRefreshTime = 0
}

function DataModel.InitRewardLevels(serverLevels)
  local homeCommon = require("Common/HomeCommon")
  DataModel.CurRepInfo = homeCommon.GetCurLvRepData(MainDataModel.StationId)
  DataModel.rewardLevels = {}
  DataModel.recordAllRewardLevelInfo = {}
  local buildingCA = PlayerData:GetFactoryData(MainDataModel.BuildingId, "BuildingFactory")
  for k, v in pairs(buildingCA.offerQuestList) do
    local t = {}
    t.bossId = v.bossId
    t.id = v.id
    t.index = k
    DataModel.recordAllRewardLevelInfo[t.id] = t
  end
  local detailLevels = serverLevels[tostring(MainDataModel.BuildingId)]
  for k, v in pairs(detailLevels.levels) do
    local info = DataModel.recordAllRewardLevelInfo[tonumber(v)]
    table.insert(DataModel.rewardLevels, info)
  end
  DataModel.SortRewardLevels()
end

function DataModel.SortRewardLevels()
  table.sort(DataModel.rewardLevels, function(a, b)
    return a.index < b.index
  end)
end

return DataModel
