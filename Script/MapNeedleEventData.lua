local MapNeedleEventData = {}
local this = MapNeedleEventData
MapNeedleEventData.MapNeedleEvents = {}
MapNeedleEventData.event = nil
MapNeedleEventData.openInsZone = false
MapNeedleEventData.scene = nil

function MapNeedleEventData.SetEventData()
  this.MapNeedleEvents = {}
  if PlayerData:GetHomeInfo().station_info.line_events then
    for _, data in pairs(PlayerData:GetHomeInfo().station_info.line_events) do
      if data.stop_events then
        for _, v in pairs(data.stop_events) do
          if not this.CheckEventCompleted(v.id) then
            this.MapNeedleEvents[tonumber(v.id)] = {
              eventData = v,
              lineId = data.line_id
            }
          end
        end
      end
    end
  end
end

function MapNeedleEventData.GetServerSpeed()
  local station_info = PlayerData:GetHomeInfo().station_info
  local curTime = TimeUtil:GetServerTimeStamp()
  local speed
  if station_info.speed_status and table.count(station_info.speed_status) ~= 0 then
    local currIndex
    table.sort(station_info.speed_status, function(a, b)
      if a[1] < b[1] then
        return true
      end
      return false
    end)
    for i = 1, #station_info.speed_status - 1 do
      if curTime >= station_info.speed_status[i][1] and curTime < station_info.speed_status[i + 1][1] then
        currIndex = i
        break
      end
    end
    if currIndex == nil then
      currIndex = #station_info.speed_status
    end
    speed = station_info.speed_status[currIndex][2]
  else
    speed = PlayerData:GetHomeInfo().speed
  end
  return speed
end

function MapNeedleEventData.IsLoginChangeNeedleEventScene()
  if not PlayerData.TempCache.FirstLogin then
    return false
  end
  local arriveStations = {}
  local station_info = PlayerData:GetHomeInfo().station_info
  for i, v in pairs(station_info.arrive_status) do
    table.insert(arriveStations, {
      id = tonumber(i),
      time = tonumber(v.time)
    })
  end
  table.sort(arriveStations, function(a, b)
    return a.time < b.time
  end)
  local curTime = TimeUtil:GetServerTimeStamp()
  local speedRatio = PlayerData:GetFactoryData(99900014, "ConfigFactory").speedRatio
  local MapDataModel = require("UIHome/UIHomeMapDataModel")
  MapDataModel.InitLineInfo()
  local remainDis = 0
  if 0 < station_info.status then
    remainDis = 0 < station_info.status and tonumber(station_info.status) or 0
  else
    remainDis = 0 < arriveStations[#arriveStations].time - curTime and (arriveStations[#arriveStations].time - curTime) * this.GetServerSpeed() / speedRatio or 0
  end
  local path = {}
  local pathIndex
  for i = 1, #arriveStations - 1 do
    local pathInfo = MapDataModel.AllStationPathRecord[arriveStations[i].id][arriveStations[i + 1].id]
    local lineId = pathInfo.id
    local needleEvents = MapNeedleEventData.GenerateServerEventData(lineId)
    if needleEvents then
      table.sort(needleEvents, function(a, b)
        return a.distance > b.distance
      end)
      table.insert(path, {
        distance = pathInfo.distance,
        needleEvents = needleEvents,
        endStationId = arriveStations[i + 1].id
      })
    end
  end
  for i = #path, 1, -1 do
    if remainDis > path[i].distance then
      remainDis = remainDis - path[i].distance
    else
      pathIndex = i
      break
    end
  end
  if pathIndex then
    local needleEvents = path[pathIndex].needleEvents
    local eventRemainDis = needleEvents[1].distance
    if remainDis <= eventRemainDis + 1 then
      local eventId = needleEvents[1].id
      this.event = eventId
      local eventCA = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
      if eventCA.loginInvoke then
        local distance = string.format("%.2f", eventRemainDis)
        Net:SendProto("station.stop", function(json)
          local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
          tradeDataModel.lastStopDistance = tradeDataModel.GetRemainDistanceStop()
        end, tostring(path[pathIndex].endStationId), distance)
      end
      return eventCA.loginInvoke
    end
  end
  return false
end

function MapNeedleEventData.GenerateServerEventData(lineId)
  if table.count(this.MapNeedleEvents) > 0 then
    local t = {}
    for i, v in pairs(this.MapNeedleEvents) do
      if tonumber(v.lineId) == tonumber(lineId) then
        table.insert(t, v.eventData)
      end
    end
    return 0 < #t and t or nil
  end
  return nil
end

function MapNeedleEventData.ResetData()
  this.MapNeedleEvents = {}
  this.event = nil
  this.openInsZone = false
  this.scene = nil
end

function MapNeedleEventData.CheckQuest(questId)
  return PlayerData:IsHaveQuest(questId)
end

function MapNeedleEventData.CheckItem(itemId, num)
  return num < PlayerData:GetGoodsById(itemId).num
end

function MapNeedleEventData.CheckLevel(levelId)
  return PlayerData.IsLevelFinished(levelId)
end

function MapNeedleEventData.CheckRole(unitId)
  return PlayerData.ServerData.roles[tostring(unitId)]
end

function MapNeedleEventData.CheckEquip(equipId)
  for i, v in pairs(PlayerData.ServerData.equipments.equips) do
    if v.id == tostring(equipId) then
      return true
    end
  end
  return false
end

function MapNeedleEventData.ParagraphCompletedCheck(paragraphCondition)
  for i, v in ipairs(paragraphCondition) do
    local find = false
    for _, id in pairs(PlayerData.plot_paragraph) do
      if tonumber(id) == v.id then
        find = true
        break
      end
    end
    if not find then
      return false
    end
  end
  return true
end

function MapNeedleEventData.LevelCompletedCheck(levelCondition)
  for i, v in ipairs(levelCondition) do
    if not this.CheckLevel(v.id) then
      return false
    end
  end
  return true
end

function MapNeedleEventData.CheckEventCompleted(eventId)
  local eventCA = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  return this.ParagraphCompletedCheck(eventCA.ParagraphBefore) and this.LevelCompletedCheck(eventCA.LevelBefore)
end

function MapNeedleEventData.CheckEventUnLock(eventId)
  local eventCA = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  if table.count(eventCA.LevelConditions) > 0 then
    for i, v in ipairs(eventCA.LevelConditions) do
      if not this.CheckLevel(v.id) then
        return false
      end
    end
  end
  if 0 < table.count(eventCA.QuestConditions) then
    for i, v in ipairs(eventCA.QuestConditions) do
      if not this.CheckQuest(v.id) then
        return false
      end
    end
  end
  if 0 < table.count(eventCA.ItemConditions) then
    for i, v in ipairs(eventCA.ItemConditions) do
      if not this.CheckItem(v.id, v.num) then
        return false
      end
    end
  end
  if 0 < table.count(eventCA.EquipmentConditions) then
    for i, v in ipairs(eventCA.EquipConditions) do
      if not this.CheckEquip(v.id) then
        return false
      end
    end
  end
  if 0 < table.count(eventCA.UnitConditions) then
    for i, v in ipairs(eventCA.UnitConditions) do
      if not this.CheckRole(v.id) then
        return false
      end
    end
  end
  return true
end

function MapNeedleEventData.EventCompletedSendServer()
  if this.event and this.CheckEventCompleted(this.event) then
    this.MapNeedleEvents[tonumber(this.event)] = nil
    TrainManager:NeedleEventFinish()
    Net:SendProto("events.happen", function(json)
    end, this.event)
    return true
  end
  return false
end

function MapNeedleEventData.ResetEventData()
  this.event = nil
  this.openInsZone = false
  this.scene = nil
end

return MapNeedleEventData
