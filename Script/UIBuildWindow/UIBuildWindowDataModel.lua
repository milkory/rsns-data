local DataModel = {
  buildCoachKeys = {},
  buildCoachList = {},
  buildingCoachId = 0,
  isBuilding = false,
  selectMainIdx = 0,
  selectChildIdx = 0,
  tween = nil,
  childSelectMovePos = {
    -277,
    0,
    277
  },
  curShowCoachId = 0,
  curShowCostMaterial = {},
  childIconPathOFF = {
    "UI/Trainfactory/Second/BuildWindows/SmallOFF",
    "UI/Trainfactory/Second/BuildWindows/NormalOFF",
    "UI/Trainfactory/Second/BuildWindows/BigOFF"
  },
  childIconPathON = {
    "UI/Trainfactory/Second/BuildWindows/SmallON",
    "UI/Trainfactory/Second/BuildWindows/NormalON",
    "UI/Trainfactory/Second/BuildWindows/BigON"
  }
}

function DataModel.InitBuildCoachList()
  DataModel.buildCoachKeys = {}
  DataModel.buildCoachList = {}
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in pairs(homeConfig.buildList) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    local key = coachCA.coachType
    if DataModel.buildCoachList[key] == nil then
      DataModel.buildCoachList[key] = {}
      local t = {}
      t.id = key
      table.insert(DataModel.buildCoachKeys, t)
    end
    local t = {}
    t.coachCA = coachCA
    if coachCA.unlockLevel > PlayerData:GetPlayerLevel() then
      t.lockDescribe = string.format(GetText(80601350), coachCA.unlockLevel)
    elseif coachCA.Achieve > 0 then
      local questCA = PlayerData:GetFactoryData(coachCA.Achieve, "QuestFactory")
      if questCA.questType == "Achieve" then
        if PlayerData.achieveList[coachCA.Achieve] and PlayerData.achieveList[coachCA.Achieve].status == 1 then
          t.lockDescribe = string.format(GetText(80601349), questCA.name)
        end
      elseif PlayerData.IsQuestComplete(coachCA.Achieve) then
        t.lockDescribe = string.format(GetText(80602335), questCA.name)
      end
    end
    table.insert(DataModel.buildCoachList[key], t)
  end
  for k, v in pairs(DataModel.buildCoachKeys) do
    for k1, v1 in pairs(DataModel.buildCoachList[v.id]) do
      if v1.lockDescribe == nil then
        v.lockDescribe = nil
        break
      else
        v.lockDescribe = v1.lockDescribe
      end
    end
  end
  DataModel.buildingCoachId = 0
  DataModel.isBuilding = false
  for k, v in pairs(PlayerData:GetHomeInfo().building) do
    DataModel.buildingCoachId = tonumber(v.id)
    local coachCA = PlayerData:GetFactoryData(DataModel.buildingCoachId, "HomeCoachFactory")
    DataModel.isBuilding = 0 < v.create_time + coachCA.waittime - TimeUtil:GetServerTimeStamp()
  end
end

return DataModel
