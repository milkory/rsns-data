local HomeUpdateHandler = {}

function HomeUpdateHandler.FurnitureTipIsActive(ufid)
  local furniture = PlayerData.ServerData.user_home_info.furniture[ufid]
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if furniture.space and furniture.space.reward_ts then
    if TimeUtil:GetServerTimeStamp() - furniture.space.reward_ts >= homeConfig.receiveTimeMin then
      return true
    else
      local totalTime = 0
      for _, v in pairs(furniture.space.creatures) do
        local creature = PlayerData:GetFactoryData(v, "HomeCreatureFactory")
        totalTime = totalTime + creature.purifyTime
      end
      if totalTime <= TimeUtil:GetServerTimeStamp() - furniture.space.start_ts then
        return true
      end
    end
  end
  return false
end

function HomeUpdateHandler.FurnitureRubbishTipIsActive(index, ufid)
  local ufids = Split(ufid, ",")
  local isShow = false
  local isHaveCan = false
  index = index + 1
  local coach = PlayerData.ServerData.user_home_info.coach[index]
  if coach == nil then
    return false
  end
  for i, v in ipairs(coach.location) do
    local ufid = v.id
    local f = PlayerData.ServerData.user_home_info.furniture[ufid]
    local fData = PlayerData:GetFactoryData(f.id, "HomeFurnitureFactory")
    local tag = PlayerData:GetFactoryData(fData.functionType, "TagFactory")
    if tag ~= nil and tag.typeName == "垃圾桶" then
      isHaveCan = true
    end
  end
  for i, ufid in ipairs(ufids) do
    local furniture = PlayerData.ServerData.user_home_info.furniture[ufid]
    local furnitureData = PlayerData:GetFactoryData(furniture.id, "HomeFurnitureFactory")
    local thisTag = PlayerData:GetFactoryData(furnitureData.functionType, "TagFactory")
    if thisTag ~= nil and thisTag.typeName == "垃圾桶" then
    elseif isHaveCan then
      return false
    end
    local currTime = TimeUtil:GetServerTimeStamp()
    local timeTable = TimeUtil:FormatUnixTime2Date(currTime)
    if furniture and furniture.waste_ts then
      local lastTime = TimeUtil:FormatUnixTime2Date(furniture.waste_ts)
      if (timeTable.year ~= lastTime.year or timeTable.month ~= lastTime.month or timeTable.day ~= lastTime.day) and not isShow then
        isShow = true
      end
    end
    if isShow then
      break
    end
  end
  return isShow
end

function HomeUpdateHandler.AdvGameOver(index)
  local Data = require("UIAdvMain/UIAdvMainDataModel")
  Data:AdvMGameOver()
end

function HomeUpdateHandler.AdvResourceGet(t)
  local Data = require("UIAdvMain/UIAdvMainDataModel")
  Data:AdvResourceGet(t, 1)
end

function HomeUpdateHandler.AdvStageStep(t)
  if t == 0 then
    local Data = require("UIAdvMain/UIAdvMainDataModel")
    AdvManager:RefreshMapMine(#Data.digItem)
  end
end

function HomeUpdateHandler.IsReachStation(stationId)
  local station_info = PlayerData:GetHomeInfo().station_info
  if station_info ~= nil then
    local status = station_info.status
    if status ~= nil and station_info.status == -1 then
      local curStayId = tonumber(station_info.sid)
      if curStayId == stationId then
        return true
      end
    end
  end
  return false
end

return HomeUpdateHandler
