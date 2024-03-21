local DataModel = {
  BuildingId = 0,
  IsCityMapIn = false,
  StationId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "FFFFFF",
  levels = {},
  curLevelSelectIdx = 0,
  refreshChecked = false,
  DayRefreshTime = 0,
  CurStationRepLv = 0,
  BoxReward = {},
  BoxRewardOffsetPosDown = {x = -83, y = -151},
  BoxRewardOffsetPosUp = {x = -83, y = 156},
  BoxRewardHeight = 225,
  BoxRewardWidth = 608,
  DeltaX = 15,
  NPCDialogEnum = {
    enterText = "enterText",
    talkText = "talkText",
    levelListText = "levelListText",
    enterOfferText = "enterOfferText"
  },
  CacheEventList = {}
}

function DataModel.GetEnergy()
  return PlayerData:GetGoodsById(11400006).num
end

function DataModel.GetRefreshItemNum()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if #homeConfig.moneyList > 0 then
    local info = homeConfig.moneyList[1]
    return PlayerData:GetGoodsById(info.id).num
  end
  return 0
end

function DataModel.InitLevelData(levels)
  DataModel.levels = {}
  local buildingCA = PlayerData:GetFactoryData(DataModel.BuildingId, "BuildingFactory")
  local pondData = {}
  for k, v in pairs(buildingCA.createQuestList) do
    pondData[v.id] = v
    pondData[v.id].index = k
  end
  local pondsValue = levels[tostring(DataModel.BuildingId)]
  if pondsValue ~= nil then
    for k1, v1 in pairs(pondsValue) do
      local curNum = 0
      local notReceived = false
      local tempLevels = v1.branch_levels or {}
      local levelId = 0
      local waves = {}
      curNum = table.count(tempLevels)
      for k2, v2 in pairs(tempLevels) do
        if v2.status ~= 1 then
          levelId = tonumber(k2)
          curNum = curNum - 1
          if v2.waves ~= nil then
            for i = 1, #v2.waves do
              waves[#waves + 1] = {
                enemyWaveId = tonumber(v2.waves[i])
              }
            end
          end
          break
        end
      end
      if levelId == 0 then
        tempLevels = v1.daily_levels or {}
        curNum = curNum + table.count(tempLevels)
        for k2, v2 in pairs(tempLevels) do
          if v2.status ~= 1 then
            levelId = tonumber(k2)
            curNum = curNum - 1
            if v2.waves ~= nil then
              for i = 1, #v2.waves do
                waves[#waves + 1] = {
                  enemyWaveId = tonumber(v2.waves[i])
                }
              end
            end
            break
          end
        end
      end
      if levelId ~= 0 then
        local pondId = tonumber(k1)
        local pondCA = PlayerData:GetFactoryData(pondId, "ListFactory")
        local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
        local t = {}
        t.pondId = pondId
        t.seriesType = pondCA.seriesType
        t.seriesName = pondCA.seriesName
        t.seriesCompleteNum = pondCA.seriesCompleteNum
        t.deterrence = pondCA.deterrence
        t.maxExpel = pondCA.expelNum
        t.curExpel = v1.expel_num
        t.limitRepLv = pondData[pondId].repCondition
        t.levelId = levelId
        t.levelName = levelCA.levelName
        t.curNum = curNum
        t.difficulty = 1
        t.waves = waves
        local canGetCount = 0
        for i, expelRewardInfo in pairs(pondCA.expelRewardList) do
          if t.curExpel >= expelRewardInfo.expel then
            canGetCount = canGetCount + 1
          end
        end
        local rewards = v1.rewards or {}
        t.canGetCount = canGetCount
        t.canGet = 0 < canGetCount and #rewards ~= canGetCount
        t.received = #rewards == #pondCA.expelRewardList
        table.insert(DataModel.levels, t)
        if t.canGet and not t.received then
          notReceived = true
        end
      end
      if notReceived then
        local nodeName = RedPointNodeStr.RedPointNodeStr.HomeSafeLevel .. DataModel.BuildingId .. "|" .. k1
        RedpointTree:InsertNode(nodeName)
        RedpointTree:ChangeRedpointCnt(nodeName, 1)
      end
    end
  end
  table.sort(DataModel.levels, function(a, b)
    return pondData[a.pondId].index < pondData[b.pondId].index
  end)
  for i = 1, #DataModel.levels do
    local levelConfig = PlayerData:GetFactoryData(DataModel.levels[i].levelId, "LevelFactory")
    if levelConfig.isCustomDifficulty then
      DataModel.levels[i].difficulty = PlayerData:GetLevelDifficulty(i)
    end
  end
end

function DataModel.CheckRefreshChecked()
  local time = PlayerData:GetPlayerPrefs("int", "refreshHomeSafe")
  if time ~= nil then
    local curTime = TimeUtil:GetServerTimeStamp()
    if 86400 < curTime - time then
      DataModel.refreshChecked = false
    else
      local t1 = TimeUtil:GetTimeStampTotalDays(time)
      local t2 = TimeUtil:GetTimeStampTotalDays(curTime)
      if t1 == t2 then
        DataModel.refreshChecked = true
      else
        DataModel.refreshChecked = false
      end
    end
  end
end

function DataModel.SetRefreshChecked()
  PlayerData:SetPlayerPrefs("int", "refreshHomeSafe", TimeUtil:GetServerTimeStamp())
end

function DataModel.InitDayRefreshTime()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  DataModel.DayRefreshTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
end

return DataModel
