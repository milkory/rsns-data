local DataModel = {
  CurSelectedId = 0,
  CurShowList = {},
  StationStartId = 0,
  StationPathRecord = {},
  AllStationPathRecord = {},
  TravelLineWayPoints = {},
  UIStationPreName = "Txt_",
  SpeedUnit = 60,
  MapDetailMask = nil,
  MapCanvasGroup = nil,
  HomeMapType = 1,
  HomeMapAnchoredPos = Vector2(-419, -34),
  StationShortestDisToOtherStation = {},
  trainDirection = nil
}

function DataModel.InitLineInfo()
  DataModel.AllStationPathRecord = {}
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local lineList = homeConfig.lineList
  for k, v in pairs(lineList) do
    local homeLineCA = PlayerData:GetFactoryData(v.id, "HomeLineFactory")
    if DataModel.AllStationPathRecord[homeLineCA.station01] == nil then
      DataModel.AllStationPathRecord[homeLineCA.station01] = {}
    end
    DataModel.AllStationPathRecord[homeLineCA.station01][homeLineCA.station02] = {}
    DataModel.AllStationPathRecord[homeLineCA.station01][homeLineCA.station02].distance = homeLineCA.distance
    DataModel.AllStationPathRecord[homeLineCA.station01][homeLineCA.station02].wayPointList = Clone(homeLineCA.wayPointList)
    DataModel.AllStationPathRecord[homeLineCA.station01][homeLineCA.station02].id = v.id
    if DataModel.AllStationPathRecord[homeLineCA.station02] == nil then
      DataModel.AllStationPathRecord[homeLineCA.station02] = {}
    end
    DataModel.AllStationPathRecord[homeLineCA.station02][homeLineCA.station01] = {}
    DataModel.AllStationPathRecord[homeLineCA.station02][homeLineCA.station01].distance = homeLineCA.distance
    local t = {}
    local count = #homeLineCA.wayPointList
    for i = count, 1, -1 do
      table.insert(t, homeLineCA.wayPointList[i])
    end
    DataModel.AllStationPathRecord[homeLineCA.station02][homeLineCA.station01].wayPointList = t
    DataModel.AllStationPathRecord[homeLineCA.station02][homeLineCA.station01].id = v.id
  end
end

function DataModel.CalcVector2Dis(pos1, pos2)
  local x = pos1.x - pos2.x
  local y = pos1.y - pos2.y
  return math.sqrt(x * x + y * y)
end

function DataModel.GetTrainCurPos(returnTableInfo)
  local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
  local isTravel = tradeDataModel.GetInTravel()
  if isTravel then
    local count = #tradeDataModel.NextCityPath
    if 0 < count then
      local curDis = tradeDataModel.GetTrainCurDistance()
      for i = 1, count - 1 do
        local info = DataModel.AllStationPathRecord[tradeDataModel.NextCityPath[i]][tradeDataModel.NextCityPath[i + 1]]
        curDis = curDis - info.distance
        if 0 >= curDis - 0.001 then
          curDis = curDis + info.distance
          if returnTableInfo ~= nil then
            returnTableInfo.lastStationId = tradeDataModel.NextCityPath[i]
            returnTableInfo.distance = curDis
          end
          return true, info.id
        end
      end
    end
  else
    return false, tradeDataModel.CurStayCity
  end
  return false, tradeDataModel.CurStayCity
end

function DataModel.CalcShortestDisPath(stationId)
  local pathRecord = {}
  local minCostId = stationId
  local t = {}
  t.cost = 0
  t.complete = true
  pathRecord[stationId] = t
  local n = 10000
  while 0 < minCostId and 0 < n do
    n = n - 1
    local parentInfo = pathRecord[minCostId]
    local toList = DataModel.AllStationPathRecord[minCostId]
    for k, v in pairs(toList) do
      local id = k
      if pathRecord[id] == nil or not pathRecord[id].complete then
        local curCost = parentInfo.cost + v.distance
        if pathRecord[id] == nil then
          t = {}
          t.cost = curCost
          t.parent = minCostId
          pathRecord[id] = t
        elseif curCost < pathRecord[id].cost then
          t = pathRecord[id]
          t.cost = curCost
          t.parent = minCostId
          pathRecord[id] = t
        end
      end
    end
    local minCost
    local recordIndex = 0
    for k, v in pairs(pathRecord) do
      if not v.complete then
        if minCost == nil then
          minCost = v.cost
          recordIndex = k
        end
        if minCost > v.cost then
          minCost = v.cost
          recordIndex = k
        end
      end
    end
    if 0 < recordIndex then
      pathRecord[recordIndex].complete = true
    end
    minCostId = recordIndex
  end
  DataModel.StationShortestDisToOtherStation[stationId] = {}
  for k, v in pairs(pathRecord) do
    t = {}
    t.distance = v.cost
    local path = {}
    local parent = k
    while parent ~= nil do
      table.insert(path, parent)
      parent = pathRecord[parent].parent
    end
    local pathLength = #path
    for i = 0, (pathLength - 1) / 2 do
      local temp = path[i + 1]
      path[i + 1] = path[pathLength - i]
      path[pathLength - i] = temp
    end
    t.path = path
    DataModel.StationShortestDisToOtherStation[stationId][k] = t
  end
end

function DataModel.GetTargetStationDistance(targetId)
  local t = {}
  local isTravel, id = DataModel.GetTrainCurPos(t)
  if isTravel then
    local lineCA = PlayerData:GetFactoryData(id, "HomeLineFactory")
    if lineCA ~= nil then
      local id1 = lineCA.station01
      local id2 = lineCA.station02
      local distance1 = 0
      local distance2 = 0
      if t.lastStationId == id1 then
        distance1 = t.distance
        distance2 = lineCA.distance - t.distance
      else
        distance2 = t.distance
        distance1 = lineCA.distance - t.distance
      end
      if DataModel.StationShortestDisToOtherStation[id1] == nil then
        DataModel.CalcShortestDisPath(id1)
      end
      distance1 = distance1 + (DataModel.StationShortestDisToOtherStation[id1][targetId].distance and DataModel.StationShortestDisToOtherStation[id1][targetId].distance or 0)
      if DataModel.StationShortestDisToOtherStation[id2] == nil then
        DataModel.CalcShortestDisPath(id2)
      end
      distance2 = distance2 + (DataModel.StationShortestDisToOtherStation[id2][targetId].distance and DataModel.StationShortestDisToOtherStation[id2][targetId].distance or 0)
      if distance1 < distance2 then
        return distance1
      else
        return distance2
      end
    end
  else
    local stationCA = PlayerData:GetFactoryData(id, "HomeStationFactory")
    if stationCA ~= nil then
      if DataModel.StationShortestDisToOtherStation[id] == nil then
        DataModel.CalcShortestDisPath(id)
      end
      local minDistance = DataModel.StationShortestDisToOtherStation[id][targetId] and DataModel.StationShortestDisToOtherStation[id][targetId].distance or 0
      return minDistance
    end
  end
end

return DataModel
