local MapNeedleData = {}
local this = MapNeedleData
MapNeedleData.CompletedNeedleList = {}
MapNeedleData.GlobalNeedleList = {}
MapNeedleData.ChildNeedleList = {}

function MapNeedleData.SetNeedleData()
  for i, lineData in pairs(PlayerData:GetHomeInfo().home_lines) do
    if lineData.completed then
      for i, id in pairs(lineData.completed) do
        this.AddCompletedNeedle(tonumber(id))
      end
    end
  end
  if PlayerData:GetHomeInfo().station_info.line_events then
    this.GlobalNeedleList = {}
    local lineCA, needleCA
    for i, data in pairs(PlayerData:GetHomeInfo().station_info.line_events) do
      lineCA = PlayerData:GetFactoryData(data.line_id, "HomeLineFactory")
      for _, v in pairs(lineCA.mapNeedleList) do
        needleCA = PlayerData:GetFactoryData(v.id, "MapNeedleFactory")
        if not needleCA.justOnce or not this.CompletedNeedleList[v.id] then
          this.GlobalNeedleList[v.id] = v.id
        end
      end
    end
  end
end

function MapNeedleData.SetChildNeedleData(mapNeedleId, remove)
  if remove then
    this.ChildNeedleList[mapNeedleId] = nil
  else
    this.ChildNeedleList[mapNeedleId] = mapNeedleId
  end
end

function MapNeedleData.ResetData()
  this.CompletedNeedleList = {}
  this.GlobalNeedleList = {}
  this.ChildNeedleList = {}
end

function MapNeedleData.CheckQuest(questId)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if questCA.activityId and questCA.activityId > 0 then
    local activityCfg = PlayerData:GetFactoryData(questCA.activityId, "ActivityFactory")
    if not TimeUtil:IsActive(activityCfg.startTime, activityCfg.endTime) then
      return false
    end
  end
  return PlayerData.GetQuestState(questId) == EnumDefine.EQuestState.UnFinish
end

function MapNeedleData.CheckItem(itemId, num)
  return num < PlayerData:GetGoodsById(itemId).num
end

function MapNeedleData.CheckLevel(levelId)
  return PlayerData.IsLevelFinished(levelId)
end

function MapNeedleData.CheckRole(unitId)
  return PlayerData.ServerData.roles[tostring(unitId)]
end

function MapNeedleData.CheckEquip(equipId)
  for i, v in pairs(PlayerData.ServerData.equipments.equips) do
    if v.id == tostring(equipId) then
      return true
    end
  end
  return false
end

function MapNeedleData.ParagraphCompletedCheck(paragraphCondition)
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

function MapNeedleData.LevelCompletedCheck(levelCondition)
  for i, v in ipairs(levelCondition) do
    if not this.CheckLevel(v.id) then
      return false
    end
  end
  return true
end

function MapNeedleData.CheckNeedleUnLock(mapNeedleId)
  local needleCA = PlayerData:GetFactoryData(mapNeedleId, "MapNeedleFactory")
  if table.count(needleCA.LevelConditions) > 0 then
    for i, v in ipairs(needleCA.LevelConditions) do
      if not this.CheckLevel(v.id) then
        return false
      end
    end
  end
  if 0 < table.count(needleCA.QuestConditions) then
    for i, v in ipairs(needleCA.QuestConditions) do
      if not this.CheckQuest(v.id) then
        return false
      end
    end
  end
  if 0 < table.count(needleCA.ItemConditions) then
    for i, v in ipairs(needleCA.ItemConditions) do
      if not this.CheckItem(v.id, v.num) then
        return false
      end
    end
  end
  if 0 < table.count(needleCA.EquipmentConditions) then
    for i, v in ipairs(needleCA.EquipConditions) do
      if not this.CheckEquip(v.id) then
        return false
      end
    end
  end
  if 0 < table.count(needleCA.UnitConditions) then
    for i, v in ipairs(needleCA.UnitConditions) do
      if not this.CheckRole(v.id) then
        return false
      end
    end
  end
  return true
end

function MapNeedleData.AddCompletedNeedle(mapNeedleId)
  if not this.CompletedNeedleList[mapNeedleId] then
    this.CompletedNeedleList[mapNeedleId] = mapNeedleId
  end
end

function MapNeedleData.NeedleCompletedSendServer()
  for i, v in pairs(this.GlobalNeedleList) do
    if this.CheckNeedleUnLock(i) then
      local needleCA = PlayerData:GetFactoryData(i, "MapNeedleFactory")
      if needleCA.justOnce and (table.count(needleCA.ParagraphBefore) > 0 or 0 < table.count(needleCA.LevelBefore)) and this.ParagraphCompletedCheck(needleCA.ParagraphBefore) and this.LevelCompletedCheck(needleCA.LevelBefore) then
        Net:SendProto("station.note_pointer", function(json)
        end, i)
        this.AddCompletedNeedle(i)
      end
    end
  end
  for i, v in pairs(this.ChildNeedleList) do
    if this.CheckNeedleUnLock(i) then
      local needleCA = PlayerData:GetFactoryData(i, "MapNeedleFactory")
      if needleCA.justOnce and (table.count(needleCA.ParagraphBefore) > 0 or 0 < table.count(needleCA.LevelBefore)) and this.ParagraphCompletedCheck(needleCA.ParagraphBefore) and this.LevelCompletedCheck(needleCA.LevelBefore) then
        Net:SendProto("station.note_pointer", function(json)
        end, i)
        this.AddCompletedNeedle(i)
      end
    end
  end
end

function MapNeedleData.CheckNeedleShow(mapNeedleId)
  local needleCA = PlayerData:GetFactoryData(mapNeedleId, "MapNeedleFactory")
  local unLock = this.CheckNeedleUnLock(mapNeedleId)
  if unLock then
    if not needleCA.justOnce then
      return true
    else
      return not this.CompletedNeedleList[mapNeedleId]
    end
  end
  return false
end

function MapNeedleData.NeedClickCheck(mapNeedleId)
  PlayerData.BattleCallBackPage = ""
  if not this.CompletedNeedleList[mapNeedleId] then
    local needleCA = PlayerData:GetFactoryData(mapNeedleId, "MapNeedleFactory")
    if table.count(needleCA.ParagraphBefore) == 0 and table.count(needleCA.LevelBefore) == 0 then
      this.AddCompletedNeedle(mapNeedleId)
      if needleCA.justOnce then
        Net:SendProto("station.note_pointer", function(json)
        end, mapNeedleId)
      end
    end
  end
  local UIMainUIController = require("UIMainUI/UIMainUIController")
  UIMainUIController.Stop()
end

function MapNeedleData.OpenStore(id)
  local stationPlace = PlayerData:GetFactoryData(id, "HomeStationPlaceFactory")
  HomeStationStoreManager:Create(stationPlace.resId, stationPlace.id)
  local coachCA = PlayerData:GetFactoryData(stationPlace.resId, "HomeCoachFactory")
  HomeStationStoreManager:Load(coachCA.defaultTemplate)
  for i, v in pairs(stationPlace.npcList) do
    HomeStationStoreManager:CreateCustom(v.id, 0, v.isRandom, v.npcX, v.npcZ, v.tree)
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local conductor = PlayerData:GetUserInfo().gender == 1 and homeConfig.conductorM or homeConfig.conductorW
  local offsetX = math.random(0, 10) >= 5 and 2 or 28
  local offsetZ = math.random(7, 10)
  HomeStationStoreManager:CreateCustom(conductor, 0, true, offsetX, offsetZ, "PassengerKCD:move")
  local c = PlayerData:GetFactoryData(stationPlace.serverId, "HomeCharacterFactory")
  HomeStationStoreManager:CreateSpeicalCharacter(stationPlace.serverId, 0, 0, c.interactiveIconPath)
  UIManager:Open("UI/CityStore/CityStore", Json.encode({
    StationId = tostring(0),
    PlaceId = tostring(id)
  }))
  local sound = SoundManager:CreateSound(stationPlace.bgm)
  if sound ~= nil then
    sound:Play()
  end
  TrainCameraManager:OpenCamera(3)
end

function MapNeedleData.GoHome()
  if MapSessionManager.currentSession then
    local mainDataModel = require("UIMainUI/UIMainUIDataModel")
    mainDataModel.SetCamera(PlayerData.FreeCameraIndex)
    MapSessionManager:GobackToMainScene()
  else
    UIManager:GoHome()
  end
end

function MapNeedleData.GoBack()
  if MapSessionManager.currentSession then
    local mainDataModel = require("UIMainUI/UIMainUIDataModel")
    mainDataModel.SetCamera(PlayerData.FreeCameraIndex)
    MapSessionManager:Goback()
  else
    UIManager:GoBack()
  end
end

return MapNeedleData
