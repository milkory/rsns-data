local DataModel = {
  pondInfo = {},
  curSelectIdx = 0,
  lastSelectView = nil,
  rencentlyTime = 0,
  rewardShow = {},
  viewType = 1
}

function DataModel.Init()
  DataModel.curSelectIdx = 0
  DataModel.lastSelectView = nil
  DataModel.pondInfo = {}
  local curTime = TimeUtil:GetServerTimeStamp()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in pairs(homeConfig.capsuleList) do
    local extractCA = PlayerData:GetFactoryData(v.id, "ExtractFactory")
    local startTime = TimeUtil:TimeStamp(extractCA.startTime)
    if curTime > startTime then
      local endTime = 0
      if extractCA.endTime ~= "" then
        endTime = TimeUtil:TimeStamp(extractCA.endTime)
      end
      if endTime == 0 or curTime < endTime then
        local t = {}
        t.id = v.id
        t.startTime = startTime
        t.endTime = endTime
        t.limit = endTime ~= 0
        t.ca = extractCA
        t.capsuleList = Clone(extractCA.capsuleList)
        local isLimitCapsule = extractCA.type == "limitCapsule"
        if isLimitCapsule then
          t.totalRemainCount = 0
        end
        for k1, v1 in pairs(t.capsuleList) do
          local factoryName = DataManager:GetFactoryNameById(v1.id)
          local qualityInt = 0
          local imagePath
          local ca = PlayerData:GetFactoryData(v1.id, factoryName)
          if factoryName == "HomeWeaponFactory" then
            qualityInt = ca.qualityInt
            imagePath = ca.imagePath
          elseif factoryName == "HomeFurnitureFactory" then
            qualityInt = ca.rarityInt
            imagePath = ca.iconPath
          else
            qualityInt = ca.qualityInt
            imagePath = ca.iconPath
          end
          v1.remainCount = v1.limitNum
          v1.qualityInt = qualityInt + 1
          v1.imagePath = imagePath
          if isLimitCapsule then
            local serverData = PlayerData.ServerData.user_home_info.pool[tostring(v.id)]
            if serverData ~= nil then
              v1.remainCount = serverData[tostring(v1.id)] or 0
              t.totalRemainCount = t.totalRemainCount + v1.remainCount
            end
          end
        end
        DataModel.SortCapsuleList(t.capsuleList)
        table.insert(DataModel.pondInfo, t)
      end
    end
  end
  table.sort(DataModel.pondInfo, function(a, b)
    if a.ca.sort > b.ca.sort then
      return true
    end
    return false
  end)
  DataModel.CalcRencentlyTime()
end

function DataModel.SortCapsuleList(t)
  table.sort(t, function(a, b)
    if a.remainCount == 0 and b.remainCount > 0 then
      return false
    elseif a.remainCount > 0 and b.remainCount == 0 then
      return true
    elseif a.qualityInt > b.qualityInt then
      return true
    elseif a.qualityInt < b.qualityInt then
      return false
    elseif a.id > b.id then
      return true
    end
    return false
  end)
end

function DataModel.CalcRencentlyTime()
  DataModel.rencentlyTime = 0
  local curTime = TimeUtil:GetServerTimeStamp()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in pairs(homeConfig.capsuleList) do
    local extractCA = PlayerData:GetFactoryData(v.id, "ExtractFactory")
    local startTime = TimeUtil:TimeStamp(extractCA.startTime)
    if curTime < startTime then
      if DataModel.rencentlyTime == 0 then
        DataModel.rencentlyTime = startTime
      elseif startTime < DataModel.rencentlyTime then
        DataModel.rencentlyTime = startTime
      end
    elseif extractCA.endTime ~= "" then
      local endTime = TimeUtil:TimeStamp(extractCA.endTime)
      if curTime < endTime then
        if DataModel.rencentlyTime == 0 then
          DataModel.rencentlyTime = endTime
        elseif endTime < DataModel.rencentlyTime then
          DataModel.rencentlyTime = endTime
        end
      end
    end
  end
end

function DataModel.GetFurnitureMoney()
  return PlayerData:GetUserInfo().furniture_coins
end

function DataModel.GetYNMoney()
  return PlayerData:GetUserInfo().gold
end

function DataModel.OnePick(callBack)
  local data = DataModel.pondInfo[DataModel.curSelectIdx]
  for k, v in pairs(data.ca.costList) do
    local temp = PlayerData:GetGoodsById(v.id)
    if temp ~= nil and temp.num < v.num then
      CommonTips.OpenTips(80600364)
      return
    end
  end
  Net:SendProto("recruit.do_caps", function(json)
    DataModel.rewardShow = json.reward_display
    DataModel.CalcServerData(data, json)
    if type(callBack) == "function" then
      callBack()
    end
  end, data.id, 1)
end

function DataModel.TenPick(callBack)
  local data = DataModel.pondInfo[DataModel.curSelectIdx]
  for k, v in pairs(data.ca.costTenList) do
    local temp = PlayerData:GetGoodsById(v.id)
    if temp ~= nil and temp.num < v.num then
      CommonTips.OpenTips(80600364)
      return
    end
  end
  Net:SendProto("recruit.do_caps", function(json)
    DataModel.rewardShow = json.reward_display
    DataModel.CalcServerData(data, json)
    if type(callBack) == "function" then
      callBack()
    end
  end, data.id, 10)
end

function DataModel.CalcServerData(data, json)
  local extractCA = PlayerData:GetFactoryData(data.id, "ExtractFactory")
  if extractCA.type == "limitCapsule" then
    PlayerData.ServerData.user_home_info.pool = json.pool
    data.totalRemainCount = 0
    local findId = {}
    local reSort = false
    for k, v in pairs(json.pool[tostring(data.id)]) do
      if k ~= "num" then
        for k1, v1 in pairs(data.capsuleList) do
          if v1.id == tonumber(k) then
            findId[v1.id] = 1
            v1.remainCount = v
            data.totalRemainCount = data.totalRemainCount + v
          end
        end
      end
    end
    for k, v in pairs(data.capsuleList) do
      if findId[v.id] == nil then
        v.remainCount = 0
        reSort = true
      end
    end
    if reSort then
      DataModel.SortCapsuleList(data.capsuleList)
    end
  end
end

return DataModel
