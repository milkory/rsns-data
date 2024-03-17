local DataModel = {
  curCoachData = nil,
  coachData = {},
  curSelectCoachIdx = 0,
  curSelectSkinIdx = 0,
  lastShowSkinIdx = 0,
  cacheUsedSkin = {},
  tempCo = nil
}

function DataModel.InitTrainSkinData()
  DataModel.curCoachData = nil
  DataModel.coachData = {}
  DataModel.cacheUsedSkin = {}
  for i, uid in pairs(PlayerData:GetHomeInfo().coach_template) do
    local serverCoach = PlayerData:GetHomeInfo().coach_store[uid]
    local coachCA = PlayerData:GetFactoryData(serverCoach.id)
    local t = {}
    t.id = serverCoach.id
    t.uid = uid
    t.name = serverCoach.name
    local usedSkin = tonumber(serverCoach.skin)
    DataModel.cacheUsedSkin[i] = serverCoach.skin
    local unlockSkin = {}
    for j, skinId in pairs(serverCoach.skin_house) do
      unlockSkin[tonumber(skinId)] = true
    end
    local tempSkinTable = {}
    for j, skinInfo in ipairs(coachCA.skinList) do
      local temp = {}
      temp.id = skinInfo.id
      temp.used = temp.id == usedSkin
      temp.isUnlock = unlockSkin[temp.id] ~= nil
      temp.idx = j
      tempSkinTable[j] = temp
    end
    t.unlockCount = #serverCoach.skin_house
    t.skins = tempSkinTable
    DataModel.SortSkinTable(tempSkinTable)
    table.insert(DataModel.coachData, t)
  end
end

function DataModel.SortSkinTable(skinTable)
  table.sort(skinTable, function(a, b)
    if a.used and not b.used then
      return true
    end
    if not a.used and b.used then
      return false
    end
    if a.isUnlock and not b.isUnlock then
      return true
    end
    if not a.isUnlock and b.isUnlock then
      return false
    end
    return a.idx < b.idx
  end)
end

return DataModel
