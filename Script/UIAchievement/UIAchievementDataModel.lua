local DataModel = {}

function DataModel:_init()
  self.achieveGroupList = {}
  self.achieveGroupList[1] = PlayerData:GetFactoryData(99900041).achievePointList[1]
  local achieveList = PlayerData:GetFactoryData(99900041).achieveList
  local count = #achieveList
  for i = 1, count do
    self.achieveGroupList[i + 1] = achieveList[i]
  end
  self.pointList = Clone(PlayerData:GetFactoryData(self.achieveGroupList[1].id).accumulateList)
  self.nowList = self.pointList
  self.quesAchiList = {}
  self.nowListIndex = 1
  self.rewardList = nil
  DataModel.nowAchiStage = 1
  DataModel.maxAchiStage = 0
  for i, v in ipairs(self.pointList) do
    if PlayerData.ServerData.quests.accumulate_rewards.sum_cnt >= v.sumCount then
      DataModel.nowAchiStage = DataModel.nowAchiStage + 1
    end
    DataModel.maxAchiStage = DataModel.maxAchiStage + 1
  end
  DataModel.disRatio = PlayerData:GetFactoryData(99900014).disRatio
  DataModel.travel_data = {}
  local travel = PlayerData:GetFactoryData(99900009).travel
  for k, v in pairs(travel) do
    DataModel.travel_data[v.id] = 1
  end
end

local Sort = function(data)
  table.sort(data, function(t1, t2)
    local status1 = PlayerData.achieveList[t1.id].status
    local status2 = PlayerData.achieveList[t2.id].status
    if status1 ~= status2 then
      return status1 > status2
    end
    if DataModel.nowListIndex == 1 then
      if status1 == 2 then
        return t1.sumCount > t2.sumCount
      else
        return t1.sumCount < t2.sumCount
      end
    end
    local sortWeight1 = PlayerData:GetFactoryData(t1.id).sort
    local sortWeight2 = PlayerData:GetFactoryData(t2.id).sort
    return sortWeight1 > sortWeight2
  end)
end

function DataModel:UpdateAchieveData(group)
  DataModel.nowListIndex = group
  if group == 1 then
    self.nowList = self.pointList
    self.pointListIndex = 1
  else
    self.nowList = {}
    Sort(PlayerData:GetFactoryData(self.achieveGroupList[group].id).achieveStartList)
    if self.quesAchiList[group] == nil then
      local showMax = 0
      for i, v in ipairs(PlayerData:GetFactoryData(self.achieveGroupList[group].id).achieveStartList) do
        local achiData = PlayerData.achieveList[v.id]
        if achiData.status == 0 then
          table.insert(self.nowList, v)
        elseif showMax < self.achieveGroupList[group].showMax then
          showMax = showMax + 1
          table.insert(self.nowList, v)
        end
      end
      self.quesAchiList[group] = self.nowList
    else
      self.nowList = self.quesAchiList[group]
    end
  end
  Sort(self.nowList)
end

function DataModel:UpdataAchevePoint(count)
  local pointCount = PlayerData.ServerData.quests.accumulate_rewards.sum_cnt
  PlayerData.ServerData.quests.accumulate_rewards.sum_cnt = pointCount + count
  for i, v in ipairs(self.pointList) do
    if PlayerData.achieveList[v.id].status == 1 and PlayerData.ServerData.quests.accumulate_rewards.sum_cnt >= v.sumCount then
      PlayerData.achieveList.finishCnt = PlayerData.achieveList.finishCnt + 1
      DataModel.nowAchiStage = DataModel.nowAchiStage + 1
      local achieveType = v.achieveList
      PlayerData.achieveList[v.id].status = 2
      local nodeName = RedpointTree.NodeNames["AchieveGroup" .. achieveType] .. "|" .. v.id
      RedpointTree:InsertNode(nodeName)
      RedpointTree:ChangeRedpointCnt(nodeName, 1)
    end
  end
end

function DataModel:SetPlayerAchieveData(id, achieveType)
  PlayerData.achieveList[id].status = 0
  if achieveType == 2 then
    PlayerData.achieveList[id].recvTime = os.time()
    PlayerData.ServerData.quests.achieve_quests[tostring(id)].recv = PlayerData.achieveList[id].recvTime
  else
    local configID = PlayerData:GetFactoryData(99900041).achievePointList[1].id
    local pointList = PlayerData:GetFactoryData(configID).accumulateList
    for i, v in ipairs(pointList) do
      if v.id == id then
        PlayerData.ServerData.quests.accumulate_rewards.accumulate_list[i] = i - 1
        break
      end
    end
  end
end

return DataModel
