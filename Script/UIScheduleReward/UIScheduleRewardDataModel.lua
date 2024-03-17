local DataModel = {
  data = nil,
  rewardInfo = {}
}

function DataModel.Init()
  local serverInfo = PlayerData.ServerData.security_levels[tostring(DataModel.data.buildingId)]
  local pondServerInfo = serverInfo[tostring(DataModel.data.pondId)]
  local pondCA = PlayerData:GetFactoryData(DataModel.data.pondId)
  local rewards = pondServerInfo.rewards or {}
  local cacheReward = {}
  for k, v in pairs(rewards) do
    cacheReward[v + 1] = true
  end
  DataModel.rewardInfo = {}
  for k, v in ipairs(pondCA.expelRewardList) do
    local t = {}
    t.idx = k
    t.needExpel = v.expel
    t.expelPercent = t.needExpel / pondCA.expelNum * 100
    t.expelPercent = math.floor(t.expelPercent + 1.0E-4)
    local ca = PlayerData:GetFactoryData(v.id)
    t.rewardItems = ca.rewardList
    t.received = cacheReward[k] ~= nil
    t.canGet = pondServerInfo.expel_num >= t.needExpel
    table.insert(DataModel.rewardInfo, t)
  end
  DataModel.Sort()
end

function DataModel.Sort()
  table.sort(DataModel.rewardInfo, function(a, b)
    if a.received and not b.received then
      return false
    end
    if not a.received and b.received then
      return true
    end
    if a.canGet and not b.canGet then
      return true
    end
    if not a.canGet and b.canGet then
      return false
    end
    return a.idx < b.idx
  end)
end

return DataModel
