local Controller = {}

function CalculateEnvId()
  local id
  local worldEnvList = PlayerData.ServerData.world_env
  local homeConfig = PlayerData:GetFactoryData(99900014)
  local configTimeScale = 86400 / homeConfig.dayScale
  local curSeverTime = math.floor(TimeUtil:GetServerTimeStamp() % 86400) + PlayerData.TimeZone * 3600
  curSeverTime = math.floor(curSeverTime % 86400)
  local daysWithGame, timeScaleWithGame = math.modf(curSeverTime / configTimeScale)
  local envConfig = PlayerData:GetFactoryData(99900052)
  if envConfig ~= nil then
    local envrimentIndex = 0
    local envrimentListLength = table.count(envConfig.environmentList)
    for index = 1, envrimentListLength do
      local environment = envConfig.environmentList[index]
      local envCA = PlayerData:GetFactoryData(environment.id)
      local startTime = envCA.timeStart / 24
      local endTime = envCA.timeEnd / 24
      if timeScaleWithGame >= startTime and timeScaleWithGame <= endTime then
        envrimentIndex = index
        break
      end
    end
    if 0 < envrimentIndex then
      local finalIndex = daysWithGame * envrimentListLength + envrimentIndex
      if finalIndex > table.count(worldEnvList) then
        finalIndex = table.count(worldEnvList)
      end
      id = worldEnvList[finalIndex]
    end
  end
  return id
end

function Controller.SetSkyRender()
  local envId
  local station_info = PlayerData:GetHomeInfo().station_info
  if station_info ~= nil then
    envId = station_info.environment
  end
  if envId == nil then
    envId = CalculateEnvId()
  end
  if envId ~= nil then
    PlayerData:ClearPollute()
    PlayerData:GetOpenMaoEffect()
    TrainEnvirParamManager:SetSpline(envId)
    PlayerData.TempCache.TrainRoadMsgId = envId
  end
end

return Controller
