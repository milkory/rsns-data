local DataModel = {
  Data = nil,
  QuestType = {
    Main = 1,
    Home = 2,
    Side = 3,
    Order = 4
  },
  AllQuests = {},
  CurSelectedMainTitle = 0,
  CurSelected = 0,
  LastShowScroll = nil,
  LastSelectBtn = nil,
  LastShowType = 0,
  CurDetailReward = {},
  CurRepReward = {},
  QuestTrace = nil,
  ConstChildElementHeight = 420
}

function DataModel.InitAllQuests(quests)
  DataModel.AllQuests = {}
  for k, v in pairs(DataModel.QuestType) do
    DataModel.AllQuests[v] = {}
  end
  local setShowName = function(t)
    local questCA = PlayerData:GetFactoryData(t.id, "QuestFactory")
    local stationCA = PlayerData:GetFactoryData(t.endStation, "HomeStationFactory")
    local strLen, charLen, cacheCharLen = string.getLength(questCA.name)
    local questLimit = 18
    local specialCharLen = 0
    local curTrustLen = 0
    for k, v in pairs(cacheCharLen) do
      local len = v
      if len <= 2 then
        len = 1
      else
        len = 2
      end
      specialCharLen = specialCharLen + len
      if questLimit <= specialCharLen then
        break
      end
      curTrustLen = curTrustLen + v
    end
    if charLen > curTrustLen then
      t.questShowName = string.sub(questCA.name, 1, curTrustLen) .. ".."
    else
      t.questShowName = questCA.name
    end
    strLen, charLen, cacheCharLen = string.getLength(stationCA.name)
    questLimit = 14
    specialCharLen = 0
    curTrustLen = 0
    for k, v in pairs(cacheCharLen) do
      local len = v
      if len <= 2 then
        len = 1
      else
        len = 2
      end
      specialCharLen = specialCharLen + len
      if questLimit <= specialCharLen then
        break
      end
      curTrustLen = curTrustLen + v
    end
    if charLen > curTrustLen then
      t.stationShowName = string.sub(stationCA.name, 1, curTrustLen) .. ".."
    else
      t.stationShowName = stationCA.name
    end
  end
  local isAllRed = false
  for k, v in pairs(quests) do
    local isTypeRed = false
    local typeRedNodeName
    if k == "station_quests" then
      typeRedNodeName = RedpointTree.NodeNames.QuestHome
      for k1, v1 in pairs(v) do
        for k2, v2 in pairs(v1) do
          if v2.time ~= -1 then
            local id = tonumber(k2)
            local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
            local localType = DataModel.QuestType[questCA.questType]
            local t = {}
            t.id = id
            t.sort = questCA.sort
            if questCA.timeLimit ~= nil and questCA.timeLimit ~= -1 then
              t.endTime = v2.time + questCA.timeLimit * 3600
            else
              t.endTime = -1
            end
            if v2.sid ~= nil then
              t.endStation = tonumber(v2.sid)
            else
              t.endStation = questCA.endStationList[1].id
            end
            t.isNew = RedpointTree:GetRedpointCnt(typeRedNodeName .. "|" .. id) > 0
            isTypeRed = isTypeRed or t.isNew
            setShowName(t)
            table.insert(DataModel.AllQuests[localType], t)
          end
        end
      end
    elseif k == "mq_quests" or k == "branch_quests" then
      typeRedNodeName = RedpointTree.NodeNames.QuestMain
      if k == "branch_quests" then
        typeRedNodeName = RedpointTree.NodeNames.QuestSide
      end
      for k1, v1 in pairs(v) do
        local id = tonumber(k1)
        local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
        if questCA == nil then
          error("任务id:" .. id .. "不存在本地配置表,请检查配置")
        end
        if QuestProcess.CheckQuestShow(id) and questCA.parentQuest == -1 and v1.recv == 0 and v1.unlock == 1 then
          local localType = DataModel.QuestType[questCA.questType]
          local t = {}
          t.id = id
          t.sort = questCA.sort
          t.endTime = -1
          if #questCA.endStationList > 0 then
            t.endStation = questCA.endStationList[1].id
          else
            t.endStation = -1
          end
          t.isNew = RedpointTree:GetRedpointCnt(typeRedNodeName .. "|" .. id) > 0
          isTypeRed = isTypeRed or t.isNew
          if t.endStation and t.endStation > 0 then
            setShowName(t)
          else
            t.questShowName = questCA.name
            t.stationShowName = ""
          end
          table.insert(DataModel.AllQuests[localType], t)
        end
      end
    elseif k == "mark_order" then
      typeRedNodeName = RedpointTree.NodeNames.QuestOrder
      for k1, v1 in pairs(v) do
        for k2, v2 in pairs(v1) do
          local id = tonumber(v2)
          local questCA = PlayerData:GetFactoryData(id)
          local localType = DataModel.QuestType[questCA.questType]
          local t = {}
          t.id = id
          t.Stationid = k1
          t.endTime = -1
          local orderCA = PlayerData:GetFactoryData(id)
          local stationCA = PlayerData:GetFactoryData(k1)
          t.orderCA = orderCA
          t.stationCA = stationCA
          t.sort = t.orderCA.sort
          t.isFinish = false
          t.isNew = RedpointTree:GetRedpointCnt(typeRedNodeName .. "|" .. id) > 0
          isTypeRed = isTypeRed or t.isNew
          table.insert(DataModel.AllQuests[localType], t)
        end
      end
    end
    if typeRedNodeName then
      if not isTypeRed then
        RedpointTree:ForceDeleteNodeChildren(typeRedNodeName)
      end
      isAllRed = isAllRed or isTypeRed
    end
  end
  for k, v in pairs(DataModel.AllQuests) do
    table.sort(v, function(a, b)
      if a.sort > b.sort then
        return true
      elseif a.sort < b.sort then
        return false
      end
      return a.id < b.id
    end)
  end
end

function DataModel.GetMergeIdx(type, childIdx)
  return type * 100 + childIdx
end

function DataModel.GetDetailTypeAndIdx(mergeIdx)
  local childIdx = mergeIdx % 100
  local type = math.modf(mergeIdx / 100)
  return type, childIdx
end

return DataModel
