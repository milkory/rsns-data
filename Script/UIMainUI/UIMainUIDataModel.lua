local DataModel = {
  envIDs = 70400001,
  startHeight = 0,
  roomID = {},
  roomSkinIds = {},
  roomData = {
    [1] = "{\"81300001\":[{\"x\":0, \"y\":0}],\"81300004\":[{\"x\":0, \"y\":0}],\"81300002\":[{\"x\":0, \"y\":0}],\"81300008\":[{\"x\":10, \"y\":10}],\"81300011\":[{\"x\":25, \"y\":0}],\"81300006\":[{\"x\":28, \"y\":3}],}",
    [2] = "{\"81300001\":[{\"x\":0, \"y\":0}],\"81300004\":[{\"x\":0, \"y\":0}],\"81300002\":[{\"x\":0, \"y\":0}],\"81300008\":[{\"x\":10, \"y\":10}],\"81300011\":[{\"x\":25, \"y\":0}],}",
    [3] = "{\"81300001\":[{\"x\":0, \"y\":0}],\"81300004\":[{\"x\":0, \"y\":0}],\"81300002\":[{\"x\":0, \"y\":0}],\"81300008\":[{\"x\":10, \"y\":10}],\"81300011\":[{\"x\":25, \"y\":0}],}"
  },
  roomFurnitureData = {},
  screenshot = {x = 800, y = 653},
  camOffsetX = 0,
  camOffsetY = -1.25,
  coachWornCost = 0,
  coachWornToCityName = "",
  tempHockReward = {},
  camTimeEffect = {},
  curTimeEffect = "",
  todayZeroTimeStamp = 0,
  oneDayTimeStamp = 86400,
  cameraTween = false,
  isOpenView = false,
  roleId = "",
  showSpine2 = false,
  isPosterGirlShow = false,
  UIShowEnum = {
    OutSide = 1,
    Coach = 2,
    Adjutant = 3,
    Passenger = 4
  },
  CurSceneName = "",
  SceneNameEnum = {Main = "Main", Home = "Home"},
  nowSoundId = 0,
  IsDrinkBuffShow = false,
  CacheQuestAwardCo = nil,
  passengerCoroutine = nil,
  FixedTime = 0,
  CurShowSceneInfo = {},
  FirstFrame = false,
  MaxCoachNum = 0,
  CurBanEnterCoachCount = 0,
  JumpRoomCtrList = {},
  SelectJumpRoomCtr = nil,
  MainToESC = false,
  TrainRushEffectPath = "UI/UIEffect/particle/UI_train_rush_ele/UI_train_rush_ele_01",
  RushTimeBtnEffectPath = "UI/UIEffect/particle/UI_rushTimeBtn/UI_rushTimeBtn_01",
  RushBuyBtnEffectPath = "UI/UIEffect/particle/UI_rushBuyBtn/UI_rushBuyBtn",
  MainRushEffectPath = "UI/UIEffect/particle/UI_mainRush/UI_mainRush",
  TrainStrikeEffectPath = "UI/UIEffect/particle/UI_train_strike/UI_train_strike",
  WarningEffectPath = "UI/UIEffect/particle/UI_Warning/UI_Warning_Particle",
  MaxDashBoardSpeed = 240,
  RushServerTime = 0,
  justArrived = false
}

function DataModel.InitModel()
  DataModel.CurrLineId = nil
  DataModel.CurrLineInfo = nil
  DataModel.AreaTipIndex = 0
  DataModel.AttractionTipIndex = 0
  DataModel.IsEvent = false
  DataModel.IsShow = nil
  DataModel.SetIsArrivingState()
  DataModel.SetTrainEventBasicId()
  DataModel.SetIsRushClick()
  DataModel.SetStrikePercent()
  DataModel.SetIsStrikeStart()
end

function DataModel.SetCamera(index)
  local ca = PlayerData:GetFactoryData(99900054).trainCameraList
  PlayerData.FreeCameraIndex = PlayerData.FreeCameraIndex + 1
  if PlayerData.FreeCameraIndex > table.count(ca) then
    PlayerData.FreeCameraIndex = 1
  end
  if index then
    PlayerData.FreeCameraIndex = index
  end
  local row = ca[PlayerData.FreeCameraIndex]
  local p_x = row.posX
  local p_y = row.posY
  local p_z = row.posZ
  local r_x = row.rotX
  local r_y = row.rotY
  local isCanMove = row.isCanMove
  local nodePath = row.nodePath
  local lastPath
  if PlayerData.cameraNodePath ~= "" and PlayerData.cameraNodePath ~= nodePath then
    lastPath = PlayerData.cameraNodePath
  end
  PlayerData.cameraNodePath = nodePath
  TrainManager:MaskAllEvent(index == 2)
  UIManager:SetCamera(Vector3(p_x, p_y, p_z), Vector3(r_x, r_y, 0), Vector3(0, row.mainPosY, row.mainPosZ), PlayerData.FreeCameraIndex - 1, lastPath)
end

function DataModel.AddFurniture(idx, data)
  table.insert(DataModel.roomFurnitureData[idx], data)
end

function DataModel.RemoveFurniture(idx, id)
  local furAry = DataModel.roomFurnitureData[idx]
  local pos = -1
  for i, v in pairs(furAry) do
    if tonumber(v.ufid) == tonumber(id) then
      pos = i
      break
    end
  end
  if pos ~= -1 then
    table.remove(DataModel.roomFurnitureData[idx], pos)
  end
end

function DataModel.RefreshData(data)
  DataModel.roomID = {}
  DataModel.roomSkinIds = {}
  DataModel.roomData = {}
  DataModel.roomFurnitureData = {}
  for i, v in pairs(data) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    local tagCA = PlayerData:GetFactoryData(coachCA.coachType)
    if not tagCA.stopCarriage then
      table.insert(DataModel.roomID, v.id)
      local json = "{"
      local furniture = {}
      for i2, v2 in pairs(v.location) do
        local fur = {}
        local serverFurData = PlayerData.ServerData.user_home_info.furniture[v2.id]
        fur.id = serverFurData.id
        fur.ufid = v2.id
        fur.x = v2.x
        fur.y = v2.y
        fur.z = v2.z or 0
        fur.skinId = PosClickHandler.GetFurnitureSkinId(v2.id)
        json = json .. "\"" .. i2 .. "\":[{ \"id\":" .. fur.id .. ", \"ufid\":" .. v2.id .. ", \"skinId\":" .. fur.skinId .. ", \"x\":" .. v2.x .. ",\"y\":" .. v2.y .. ",\"z\":" .. fur.z .. "}],"
        table.insert(furniture, {
          ufid = v2.id,
          id = fur.id,
          skinId = fur.skinId
        })
      end
      json = json .. "}"
      table.insert(DataModel.roomData, json)
      table.insert(DataModel.roomFurnitureData, furniture)
    end
    local skinId = tonumber(v.skin)
    if skinId == nil then
      skinId = coachCA.defaultSkin
    end
    table.insert(DataModel.roomSkinIds, skinId)
  end
end

function DataModel.AutoCompleteOrder()
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  if TradeDataModel.GetIsTravel() then
    return
  end
  local completeQuests = {}
  local idStr = ""
  for k, v in pairs(PlayerData:GetHomeInfo().stations) do
    if v.quests ~= nil then
      for k1, v1 in pairs(v.quests) do
        for k2, v2 in pairs(v1) do
          if v2.time ~= -1 and k1 == "Send" and TradeDataModel.CurStayCity == v2.sid then
            if idStr == "" then
              idStr = idStr .. k2
            else
              idStr = idStr .. "," .. k2
            end
            local t = {}
            t.stationId = k
            t.questId = k2
            table.insert(completeQuests, t)
          end
        end
      end
    end
  end
  if idStr ~= "" then
    Net:SendProto("station.complete_quest", function(json)
      CommonTips.OpenShowItem(json.reward)
      local showQuests = {}
      for k1, v1 in pairs(completeQuests) do
        table.insert(showQuests, tonumber(v1.questId))
        PlayerData:GetHomeInfo().stations[v1.stationId].quests.Send[v1.questId] = nil
        local questConfig = PlayerData:GetFactoryData(v1.questId, "QuestFactory")
        for k, v in pairs(questConfig.goodsList) do
          if PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] ~= nil then
            local num = PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num
            num = num - v.num
            if num <= 0 then
              PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = 0
            else
              PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = num
            end
          end
        end
      end
      CommonTips.OpenQuestsCompleteTip(showQuests)
      QuestTrace.CompleteQuest(showQuests)
    end, idStr)
  end
end

function DataModel:GetNextSoundTime()
  math.randomseed(os.time())
  local TrustConfig = PlayerData:GetFactoryData(99900039)
  self.nextDelay = TrustConfig.talkIntervalMin + math.random(0, TrustConfig.talkIntervalRandom)
  self.nextPlaySoundTime = self.nextDelay + os.time()
end

function DataModel:InitRoleTrustData()
  local TrustConfig = PlayerData:GetFactoryData(99900039)
  self.lastGetTime = 0
  self.getTrustValueTime = TrustConfig.clientGetExpInterval
  self.soundEndTime = 0
  self.roleAudioList = {}
  self.roleAudioCount = 0
  local roleId = PlayerData:GetUserInfo().receptionist_id
  local roleConfig = PlayerData:GetFactoryData(roleId)
  local file_id = roleConfig.fileList[1].file
  local file_cfg = PlayerData:GetFactoryData(file_id)
  local tempList = {}
  local has_gender_sound = file_cfg.AudioM and next(file_cfg.AudioM)
  if has_gender_sound then
    local gender = PlayerData:GetUserInfo().gender or 1
    local gender_list = gender == 1 and file_cfg.AudioM or file_cfg.AudioF
    local normal_list = file_cfg.TrustAudio
    local normal_indx = 1
    local gender_indx = 1
    while normal_list[normal_indx] or gender_list[gender_indx] do
      if gender_list[gender_indx] == nil then
        table.insert(tempList, normal_list[normal_indx])
        normal_indx = normal_indx + 1
      elseif normal_list[normal_indx] == nil then
        table.insert(tempList, gender_list[gender_indx])
        gender_indx = gender_indx + 1
      elseif normal_list[normal_indx].UnlockLevel <= gender_list[gender_indx].UnlockLevel then
        table.insert(tempList, normal_list[normal_indx])
        normal_indx = normal_indx + 1
      else
        table.insert(tempList, gender_list[gender_indx])
        gender_indx = gender_indx + 1
      end
    end
  else
    tempList = file_cfg.TrustAudio
  end
  local roleId = PlayerData:GetUserInfo().receptionist_id
  if roleId then
    local trust_lv = PlayerData:GetRoleById(roleId).trust_lv or 1
    for k, v in pairs(tempList) do
      if trust_lv >= v.UnlockLevel then
        self.roleAudioList[k] = v
        self.roleAudioCount = self.roleAudioCount + 1
      end
    end
  end
end

function DataModel.GetCurShowSceneInfo(stationId)
  if not stationId then
    stationId = 0
    local stop_info = PlayerData:GetHomeInfo().station_info.stop_info
    if stop_info ~= nil and stop_info[2] == -1 then
      stationId = stop_info[1]
    else
      stationId = 83000020
    end
  end
  local homeCommon = require("Common/HomeCommon")
  DataModel.CurShowSceneInfo = homeCommon.GetCurShowSceneInfo(stationId)
end

function DataModel.SetTrainEventBasicId(eventId, levelId, lineId, areaId)
  DataModel.TrainEventId = eventId
  DataModel.TrainLevelId = levelId
  DataModel.TrainLineId = lineId
  if areaId ~= 0 then
    DataModel.TrainEventAreaId = areaId
  else
    DataModel.TrainEventAreaId = nil
  end
end

function DataModel.GetTrainEventAreaId()
  return DataModel.TrainEventAreaId
end

function DataModel.SetTrainEventBgmId(bgmId)
  DataModel.TrainEventBgmId = bgmId
end

function DataModel.SetIsRushClick(state)
  DataModel.IsRushClick = state
end

function DataModel.GetIsRushClick()
  return DataModel.IsRushClick
end

function DataModel.GetStrikeSuccessPercent(eventId, lineId)
  local strike = PlayerData.GetStrike()
  if not strike.id then
    return 0
  end
  local strikeCfg = PlayerData:GetFactoryData(strike.id)
  local ratioA = strikeCfg.configWinPercent
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local speedRatio = homeConfig.speedRatio
  local eventCfg = PlayerData:GetFactoryData(eventId)
  local lineCfg = PlayerData:GetFactoryData(lineId, "HomeLineFactory")
  local eventHp = eventCfg.hp * lineCfg.eventHpRatio
  local successRatio = ratioA + (TrainManager.TargetSpeed * speedRatio + strikeCfg.power - eventHp) / eventHp
  successRatio = math.min(100, math.max(1, math.floor(successRatio * 100)))
  return successRatio
end

function DataModel.SetRushNumber(rushNumber)
  DataModel.RushNumber = rushNumber
end

function DataModel.GetRushNumber()
  return DataModel.RushNumber
end

function DataModel.SetIsStrikeStart(state)
  DataModel.IsStrikeStart = state
end

function DataModel.GetIsStrikeStart()
  return DataModel.IsStrikeStart
end

function DataModel.GetTrainEventId()
  return DataModel.TrainEventId
end

function DataModel.GetTrainLineId()
  return DataModel.TrainLineId
end

function DataModel.SetStrikePercent(percent)
  DataModel.StrikePercent = percent
end

function DataModel.GetStrikePercent()
  return DataModel.StrikePercent
end

function DataModel.SetIsRushing(state)
  DataModel.IsRushing = state
end

function DataModel.GetIsRushing()
  return DataModel.IsRushing
end

function DataModel.SetWeaponRushDuration(duration)
  DataModel.WeaponRushDuration = duration
end

function DataModel.GetWeaponRushDuration()
  return DataModel.WeaponRushDuration
end

function DataModel.SetIsWeaponRushShow(isShow)
  DataModel.IsWeaponRushShow = isShow
end

function DataModel.GetIsWeaponRushShow()
  return DataModel.IsWeaponRushShow
end

function DataModel.SetIsArrivingState(state)
  DataModel.IsArriving = state
end

function DataModel.GetIsArrivingState()
  return DataModel.IsArriving
end

function DataModel.GetBeforeCantEnterRoomCount(roomIndex)
  local beforeCantEnterRoomCount = 0
  if 1 < roomIndex then
    for i = 1, roomIndex - 1 do
      local coachData = PlayerData:GetHomeInfo().coach[i]
      local coachCA = PlayerData:GetFactoryData(coachData.id, "HomeCoachFactory")
      local typeCA = PlayerData:GetFactoryData(coachCA.coachType, "TagFactory")
      if typeCA.stopCarriage then
        beforeCantEnterRoomCount = beforeCantEnterRoomCount + 1
      end
    end
  end
  return beforeCantEnterRoomCount
end

function DataModel.SetTrainEventLv(lv)
  DataModel.TrainEventLv = lv
end

function DataModel.GetTrainEventLv()
  return DataModel.TrainEventLv
end

function DataModel.SetRushRemainTime(remainTime)
  DataModel.TrainRushRemainTime = remainTime
end

function DataModel.GetRushRemainTime()
  return DataModel.TrainRushRemainTime
end

function DataModel.ShowHomeBuffTips()
  local buff = PlayerData:GetCurStationStoreBuff(PlayerData:GetCurTrainBuffType())
  local drinkBuff = PlayerData:GetCurDrinkBuff()
  local battleBuff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
  if buff ~= nil or drinkBuff ~= nil or battleBuff ~= nil then
    local t = {}
    t.posX = -479
    t.posY = -409
    t.drinkBuff = drinkBuff
    t.stationStoreBuff = buff
    t.battleBuff = battleBuff
    UIManager:Open("UI/Common/HomeBuff", Json.encode(t))
  end
end

return DataModel
