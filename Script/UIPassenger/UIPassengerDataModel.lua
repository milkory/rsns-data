local DataModel = {}
local this = DataModel
DataModel.passengerList = {}
DataModel.orderPassengerList = {}
DataModel.enterSound = nil
DataModel.outSound = nil

function DataModel.RefreshOrderPassengerList(orderInfo)
  DataModel.orderPassengerList = {}
  for i, v in pairs(orderInfo.passengerList) do
    local info = {}
    info.passengerCA = PlayerData:GetFactoryData(v.id, "PassageFactory")
    info.num = v.num
    table.insert(DataModel.orderPassengerList, info)
  end
end

function DataModel.GetPsgFurIndex(psgUid, psgData)
  local furniture = PlayerData:GetHomeInfo().furniture[psgData.u_fid]
  for index, psgUid1 in pairs(furniture.passenger) do
    if psgUid1 ~= "" and psgUid1 == psgUid then
      return index
    end
  end
  return -1
end

function DataModel.GetPsgFurRoomIndex(u_fid)
  local furniture = PlayerData:GetHomeInfo().furniture[u_fid]
  local coachRoom = {}
  for i, v in ipairs(PlayerData.ServerData.user_home_info.coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    if coachCA.coachType ~= 12600247 then
      table.insert(coachRoom, PlayerData.ServerData.user_home_info.coach_template[i])
    end
  end
  for roomIdx, u_cid in pairs(coachRoom) do
    if u_cid == furniture.u_cid then
      return roomIdx
    end
  end
  return -1
end

function DataModel.CreatePassenger(psgUid, psgData)
  local passengerCA = PlayerData:GetFactoryData(psgData.id, "PassageFactory")
  local furIndex = this.GetPsgFurIndex(psgUid, psgData)
  local roomIdx = this.GetPsgFurRoomIndex(psgData.u_fid)
  if furIndex ~= -1 and roomIdx ~= -1 then
    if not PosClickHandler.GetRoomIsHaveEmptyTile(roomIdx) then
      return nil
    end
    return HomeCharacterManager:CreatePassengerCharacter(psgUid, tonumber(passengerCA.homePassage), psgData.u_fid, furIndex - 1, roomIdx - 1), furIndex
  end
  return nil
end

function DataModel.CreateHomePassenger()
  local sitNum = math.floor(PlayerData:GetCurPassengerNum() * 0.7)
  HomeCharacterManager:SetSitNum(sitNum)
  HomeCharacterManager:ResetCurSitNun()
  local curSitNum = 0
  for i, v in pairs(PlayerData:GetHomeInfo().passenger) do
    for psgUid, psgData in pairs(v) do
      local character, furIndex = this.CreatePassenger(psgUid, psgData)
      if character and sitNum > curSitNum then
        curSitNum = curSitNum + 1
        local passengerCA = PlayerData:GetFactoryData(psgData.id, "PassageFactory")
        local characterCA = PlayerData:GetFactoryData(passengerCA.homePassage, "HomeCharacterFactory")
        local time = 0 < characterCA.maxTime and math.random(characterCA.minTime, characterCA.maxTime) or math.random(characterCA.minTime, 15)
        HomeCharacterManager:InitContinuousOp(character, psgData.u_fid, furIndex - 1, time)
      end
    end
  end
end

local GetPsgDataByUid = function(psgDataList, uid)
  for i, v in pairs(psgDataList) do
    for psgUid, psgData in pairs(v) do
      if psgUid == uid then
        return psgData
      end
    end
  end
  return nil
end

function DataModel.RefreshPassenger(newPsgData, newFurnitureData)
  if not newPsgData or not newFurnitureData then
    return
  end
  local oldFurData
  for i, furData in pairs(newFurnitureData) do
    oldFurData = PlayerData.ServerData.user_home_info.furniture[i]
    if oldFurData then
      for k, v in pairs(oldFurData) do
        if furData[k] then
          oldFurData[k] = furData[k]
        end
      end
    end
  end
  local mainUIDataModel = require("UIMainUI/UIMainUIDataModel")
  if MainManager.bgSceneName == mainUIDataModel.SceneNameEnum.Home then
    local addPsg = {}
    local reducePsg = {}
    for i, v in pairs(newPsgData) do
      for psgUid, psgData in pairs(v) do
        if not GetPsgDataByUid(PlayerData:GetHomeInfo().passenger, psgUid) then
          addPsg[psgUid] = psgData
        end
      end
    end
    for i, v in pairs(PlayerData:GetHomeInfo().passenger) do
      for psgUid, psgData in pairs(v) do
        if not GetPsgDataByUid(newPsgData, psgUid) then
          reducePsg[psgUid] = psgData
        end
      end
    end
    local curNum = 0
    for _, v in pairs(newPsgData) do
      curNum = curNum + table.count(v)
    end
    HomeCharacterManager:SetSitNum(curNum)
    for psgUid, v in pairs(reducePsg) do
      HomeCharacterManager:RecyclePassenger(psgUid)
    end
    for psgUid, psgData in pairs(addPsg) do
      local character, furIndex = this.CreatePassenger(psgUid, psgData)
      if character then
        local passengerCA = PlayerData:GetFactoryData(psgData.id, "PassageFactory")
        local characterCA = PlayerData:GetFactoryData(passengerCA.homePassage, "HomeCharacterFactory")
        local time = 0 < characterCA.maxTime and math.random(characterCA.minTime, characterCA.maxTime) or math.random(characterCA.minTime, 15)
        HomeCharacterManager:InitContinuousOp(character, psgData.u_fid, furIndex - 1, time)
      end
    end
  end
  PlayerData:GetHomeInfo().passenger = newPsgData
end

function DataModel.GetPassengerList()
  local passenger = PlayerData:GetHomeInfo().passenger
  local t = {}
  local key = ""
  for endStationId, v in pairs(passenger) do
    for psgUid, psgData in pairs(v) do
      key = string.format("%s_%s_%s_%s", psgData.origin, endStationId, psgData.id, psgData.psg_tag)
      t[key] = t[key] or {}
      table.insert(t[key], {
        startStationId = tonumber(psgData.origin),
        endStationId = tonumber(endStationId),
        psgUid = psgUid,
        psgData = psgData
      })
    end
  end
  local passengerList = {}
  for _, v in pairs(t) do
    table.insert(passengerList, v)
  end
  return passengerList
end

local tagList = {}
local startStation
local minDistanceList = {}
local AroundFind = function(station)
  local aroundLineList = {}
  for i, v in pairs(CacheAndGetFactory("HomeLineFactory")) do
    if v.station01 == station then
      table.insert(aroundLineList, {
        aroundId = v.station02,
        lineId = v.id,
        distance = v.distance
      })
    elseif v.station02 == station then
      table.insert(aroundLineList, {
        aroundId = v.station01,
        lineId = v.id,
        distance = v.distance
      })
    end
  end
  for i, v in pairs(aroundLineList) do
    minDistanceList[startStation][v.aroundId] = minDistanceList[startStation][v.aroundId] or {}
    local beforeLineList = minDistanceList[startStation][v.aroundId]
    if table.count(beforeLineList) > 0 then
      local beforeDistance = 0
      for i, lineId in pairs(beforeLineList) do
        beforeDistance = PlayerData:GetFactoryData(lineId, "HomeLineFactory").distance + beforeDistance
      end
      local startToParentLine = minDistanceList[startStation][station]
      local distance = this.GetLineDistance(startToParentLine)
      if beforeDistance > distance + v.distance then
        minDistanceList[startStation][v.aroundId] = {}
        for i, lineId in pairs(startToParentLine) do
          table.insert(minDistanceList[startStation][v.aroundId], lineId)
        end
        table.insert(minDistanceList[startStation][v.aroundId], v.lineId)
      end
    else
      local startToParentLine = minDistanceList[startStation][station]
      if startToParentLine then
        for i, lineId in pairs(startToParentLine) do
          table.insert(minDistanceList[startStation][v.aroundId], lineId)
        end
      end
      table.insert(minDistanceList[startStation][v.aroundId], v.lineId)
    end
  end
  return aroundLineList
end

local function InitNearestLine(station)
  if not station or tagList[station] then
    return
  end
  tagList[station] = station
  minDistanceList[startStation] = minDistanceList[startStation] or {}
  local aroundLineList = AroundFind(station)
  for i, v in pairs(aroundLineList) do
    InitNearestLine(v.aroundId)
  end
end

function DataModel.GetNearestLine(station1, station2)
  tagList = {}
  startStation = station1
  if minDistanceList[station1] and minDistanceList[station1][station2] then
    return minDistanceList[station1][station2]
  elseif minDistanceList[station2] and minDistanceList[station2][station1] then
    return minDistanceList[station2][station1]
  else
    InitNearestLine(station1)
    return minDistanceList[station1][station2]
  end
end

function DataModel.GetNearestLineDistance(station1, station2)
  station1 = tonumber(station1)
  station2 = tonumber(station2)
  if not station1 or not station2 then
    return
  end
  local lineList = this.GetNearestLine(station1, station2)
  local distance = 0
  lineList = lineList or {}
  for i, lineId in pairs(lineList) do
    distance = PlayerData:GetFactoryData(lineId, "HomeLineFactory").distance + distance
  end
  return distance
end

function DataModel.GetLineDistance(lineList)
  local distance = 0
  lineList = lineList or {}
  for i, lineId in pairs(lineList) do
    distance = PlayerData:GetFactoryData(lineId, "HomeLineFactory").distance + distance
  end
  return distance
end

local GetPassengerStart = function(id)
  return PlayerData:GetFactoryData(id, "PassageFactory").star
end

function DataModel.SetPassengerListByLevel()
  local psgList = this.GetPassengerList()
  table.sort(psgList, function(a, b)
    return GetPassengerStart(a[1].psgData.id) < GetPassengerStart(b[1].psgData.id)
  end)
  this.passengerList = psgList
end

function DataModel.SetPassengerListByDistance()
  local psgList = this.GetPassengerList()
  table.sort(psgList, function(a, b)
    return this.GetNearestLineDistance(a[1].startStationId, a[1].endStationId) < this.GetNearestLineDistance(b[1].startStationId, b[1].endStationId)
  end)
  this.passengerList = psgList
end

function DataModel.GetOutPassengerList(json, length)
  local roleIds = {}
  local psgInfos = {}
  for destination, v in pairs(PlayerData:GetHomeInfo().passenger) do
    if not json.passenger[destination] then
      for uid, info in pairs(v) do
        local psgInfo = {}
        psgInfo.id = info.id
        table.insert(psgInfos, psgInfo)
      end
      break
    end
  end
  table.sort(psgInfos, function(a, b)
    local psgCA1 = PlayerData:GetFactoryData(a.id, "PassageFactory")
    local psgCA2 = PlayerData:GetFactoryData(b.id, "PassageFactory")
    if psgCA1.star == psgCA2.star then
      return tonumber(psgCA1.homePassage) < tonumber(psgCA2.homePassage)
    else
      return psgCA1.star < psgCA2.star
    end
  end)
  for k, v in ipairs(psgInfos) do
    local passengerCA = PlayerData:GetFactoryData(v.id, "PassageFactory")
    table.insert(roleIds, tonumber(passengerCA.homePassage))
    if length and length <= #roleIds then
      break
    end
  end
  return roleIds
end

function DataModel.CreateNpc(enter)
  MainSceneCharacterManager:InitNpcPos()
  local npcListCA = PlayerData:GetFactoryData(80302056, "ListFactory")
  local leftIndex = math.random(1, table.count(npcListCA.passengerAction1))
  local psgCA = PlayerData:GetFactoryData(npcListCA.passengerAction1[leftIndex].id)
  MainSceneCharacterManager:CreateNpc(psgCA.homePassage, 0, true)
  local rightIndex = math.random(1, table.count(npcListCA.passengerAction2))
  psgCA = PlayerData:GetFactoryData(npcListCA.passengerAction2[rightIndex].id)
  MainSceneCharacterManager:CreateNpc(psgCA.homePassage, 0, false)
  local runIndex = math.random(1, table.count(npcListCA.passengerAction3))
  psgCA = PlayerData:GetFactoryData(npcListCA.passengerAction3[runIndex].id)
  MainSceneCharacterManager:CreateNpc(psgCA.homePassage, 1, enter)
  local walkIndex = math.random(1, table.count(npcListCA.passengerAction4))
  psgCA = PlayerData:GetFactoryData(npcListCA.passengerAction4[walkIndex].id)
  MainSceneCharacterManager:CreateNpc(psgCA.homePassage, 2, enter)
  local idleIndex = math.random(1, table.count(npcListCA.passengerAction5))
  psgCA = PlayerData:GetFactoryData(npcListCA.passengerAction5[idleIndex].id)
  MainSceneCharacterManager:CreateNpc(psgCA.homePassage, 3, enter)
  local idleIndex2 = math.random(1, table.count(npcListCA.passengerAction6))
  psgCA = PlayerData:GetFactoryData(npcListCA.passengerAction6[idleIndex2].id)
  MainSceneCharacterManager:CreateNpc(psgCA.homePassage, 4, enter)
  if enter then
    local enterSound = SoundManager:CreateSound(30002451)
    enterSound:Play()
  else
  end
end

return DataModel
