local Train = {IsKeyEvent = false}

function Train.Stop(sid, distance, isAstern)
  local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
  local mainController = require("UIMainUI/UIMainUIController")
  mainController.ChangeDriveBtnState()
  mainController.SetRushEffectState(false)
  local realDistance, realId
  if PlayerData:GetHomeInfo().station_info.status >= 0 then
    if isAstern then
      realDistance = PlayerData:GetHomeInfo().station_info.status
      realId = PlayerData:GetHomeInfo().station_info.sid
    else
      return
    end
  end
  local cb = function(distance)
    distance = string.format("%.2f", distance)
    Net:SendProto("station.stop", function(json)
      tradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh, TrainManager.CurrTrainState == TrainState.Astern)
    end, tostring(sid), distance, function(json)
    end)
  end
  if realId then
    local serverIndex, currIndex = 0, 0
    if tostring(realId) ~= tostring(sid) then
      local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
      for i, v in ipairs(TradeDataModel.Path) do
        if tostring(v.targetId) == tostring(realId) then
          serverIndex = i
        end
        if tostring(v.targetId) == tostring(sid) then
          currIndex = i
        end
      end
      if serverIndex > currIndex then
        cb(distance)
      else
        print_r("不发送停车协议，没倒车成功，以前端逻辑为准")
      end
    elseif distance > realDistance then
      cb(distance)
    else
      print_r("不发送停车协议，没倒车成功，以前端逻辑为准")
    end
  else
    cb(distance)
  end
end

function Train.Event(sid, eventId, distance, lineId, areaId, lv)
  print_r("Train.Event", eventId, distance, lineId, areaId, lv)
  print_r(PlayerData:GetHomeInfo().station_info)
  Train.CloseLevelEventIndexUI()
  local mainController = require("UIMainUI/UIMainUIController")
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    if UIManager:IsTipOpened("UI/Common/Prompt/Prompt") then
      UIManager:CloseTip("UI/Common/Prompt/Prompt")
    end
    if UIManager:IsTipOpened("UI/Common/GoodsTips") then
      UIManager:CloseTip("UI/Common/GoodsTips")
    end
  end
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  if event.mod == "插针停车点" then
    distance = string.format("%.2f", distance)
    MapNeedleEventData.event = eventId
    local cb = function()
      mainController.MainLineEventShow(eventId, false)
      mainController.ChangeDriveBtnState()
      MapSessionManager:InvokeNeedleEvent(eventId)
    end
    if PlayerData:GetHomeInfo().station_info.status >= 0 then
      cb()
    else
      Net:SendProto("station.stop", function(json)
        cb()
      end, tostring(sid), distance)
    end
    return
  end
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  mainDataModel.SetTrainEventBasicId(eventId, event.levelId, lineId, areaId)
  mainDataModel.SetCamera(2)
  mainController.SetRushEffectState(false)
  mainDataModel.SetTrainEventLv(lv)
  if event.isAuto then
    if event.mod == "关卡事件" then
      local StartBattle = require("UISquads/View_StartBattle")
      local currentSquad = {}
      local curRoleList = PlayerData.ServerData.squad[1].role_list
      for i = 1, 5 do
        local temp = {}
        temp = curRoleList[i]
        if temp and temp.id == "" then
          temp.id = nil
        end
        table.insert(currentSquad, temp)
      end
      local DataController = require("UISquads/UISquadsDataController")
      local curSquad = DataController:GetRoleDataList(currentSquad)
      StartBattle:StartBattle(event.levelId, 0, curSquad, 1, nil, false, eventId)
    end
  else
    distance = string.format("%.2f", distance)
    local cb = function()
      local mainController = require("UIMainUI/UIMainUIController")
      mainController.MainLineEventShow(eventId, true, false)
      mainController.ChangeDriveBtnState()
      mainController:RunBtnState(false)
      PlayerData.TempCache.EventFinish = false
      GuideManager:TriggerMeetEvent(tonumber(eventId) or 0)
      if event.isStoryStart then
        UIManager:Open(UIPath.UIDialog, Json.encode({
          id = event.paragraphId
        }))
      end
    end
    if PlayerData:GetHomeInfo().station_info.status >= 0 then
      cb()
    else
      Net:SendProto("station.stop", function(json)
        cb()
      end, tostring(sid), distance, function(json)
      end)
    end
  end
end

function Train.Eventing(eventId, areaId)
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  Train.CloseLevelEventIndexUI()
  if event.isDeceleration then
    local mainController = require("UIMainUI/UIMainUIController")
    mainController.ChangeDriveBtnState()
    mainController:RunBtnState(false)
  end
end

local TradeDataModel = require("UIHome/UIHomeTradeDataModel")

function Train.EventBattleFinish(json)
  local battleInfo = PlayerData.BattleInfo
  local battleResult = PlayerData.BattleInfo.BattleResult
  if battleInfo ~= nil and battleResult ~= nil then
    local isWin = battleResult.isWin
    local duration = battleResult.duration
    local reward = json.reward
    local deckInfo = json.roles
    local levelId = battleInfo.battleStageId
    local levelDifficulty = PlayerData.BattleInfo.difficulty or 1
    SdkReporter.TrackBattleFinish(isWin, levelId, levelDifficulty, Json.encode(reward), duration, Json.encode(deckInfo))
  end
  if PlayerData.GetIsTest() then
    return
  end
  PlayerData.FreeCameraIndex = 1
  MapNeedleData.NeedleCompletedSendServer()
  if MapNeedleEventData.EventCompletedSendServer() then
    local MainDataModel = require("UIMainUI/UIMainUIDataModel")
    MainDataModel.SetCamera(PlayerData.FreeCameraIndex)
    PlayerData.TempCache.MainUIShowState = MainDataModel.UIShowEnum.OutSide
    if json.minus_durable then
      PlayerData.TempCache.minus_durable = json.minus_durable
      PlayerData:GetHomeInfo().readiness.repair.current_durable = PlayerData:GetHomeInfo().readiness.repair.current_durable - json.minus_durable
    end
    PlayerData.BattleCallBackPage = ""
    MapNeedleEventData.ResetEventData()
    return
  end
  if not TradeDataModel.GetInTravel() then
    PlayerData.TempCache.EventIndex = nil
    PlayerData.TempCache.Sid = nil
    PlayerData.TempCache.NextDistance = nil
    PlayerData.TempCache.AreaId = nil
    return
  end
  local MainDataModel = require("UIMainUI/UIMainUIDataModel")
  local cfg = PlayerData:GetFactoryData(MainDataModel.TrainEventId)
  local isWin = PlayerData.BattleInfo.BattleResult.isWin
  if not cfg then
    PlayerData.TempCache.EventIndex = nil
    PlayerData.TempCache.Sid = nil
    PlayerData.TempCache.NextDistance = nil
    PlayerData.TempCache.AreaId = nil
    return
  end
  TradeDataModel.StateEnter = EnumDefine.TrainStateEnter.Refresh
  if isWin then
    PlayerData.FreeCameraIndex = 1
    MainDataModel.SetCamera(PlayerData.FreeCameraIndex)
    PlayerData.TempCache.EventFinish = true
    PlayerData.TempCache.MainUIShowState = MainDataModel.UIShowEnum.OutSide
    if cfg.mod == "关卡事件" then
      TrainManager:LevelEventFinish()
    elseif cfg.mod == "点击关卡" then
      if PlayerData.TempCache.EventIndex then
        local t = string.split(PlayerData.TempCache.EventIndex, ":")
        TrainManager:DeleteClickEventByIndex(tonumber(t[2]))
      end
    elseif cfg.mod == "污染点击事件" or cfg.mod == "点击副本事件" then
      if cfg.mod == "点击副本事件" then
        PlayerData:RefreshPolluteData()
      end
      if cfg.mod == "污染点击事件" then
        if PlayerData.pollute_areas[tostring(PlayerData.TempCache.AreaId)].click_level_events[tostring(PlayerData.TempCache.EventIndex)] == tostring(MainDataModel.TrainEventId) then
          PlayerData.Last_Chapter_Parms = {
            areaId = PlayerData.TempCache.AreaId,
            eventId = MainDataModel.TrainEventId,
            eventIndex = PlayerData.TempCache.EventIndex,
            type = "pollute"
          }
          PlayerData.BattleCallBackPage = "UI/Chapter/Battle_Dungeon"
        else
          PlayerData.BattleCallBackPage = ""
        end
      elseif cfg.mod == "点击副本事件" then
        if PlayerData.pollute_areas[tostring(PlayerData.TempCache.AreaId)].click_dungeon_events[tostring(PlayerData.TempCache.EventIndex)] == tostring(MainDataModel.TrainEventId) then
          local num = PlayerData:GetDungeonNum(PlayerData.TempCache.AreaId, PlayerData.TempCache.EventIndex)
          if num < cfg.countMax then
            PlayerData.Last_Chapter_Parms = {
              areaId = PlayerData.TempCache.AreaId,
              eventId = MainDataModel.TrainEventId,
              eventIndex = PlayerData.TempCache.EventIndex,
              type = "dungeon"
            }
            PlayerData.BattleCallBackPage = "UI/Chapter/Battle_Dungeon"
          else
            PlayerData.BattleCallBackPage = ""
          end
        else
          PlayerData.BattleCallBackPage = ""
        end
      end
    end
    if json.station_info then
      TradeDataModel.Refresh3DTravelInfoNew(cfg.isDrive and EnumDefine.TrainStateEnter.BattleFinish or EnumDefine.TrainStateEnter.Refresh)
    end
    if not cfg.isDrive then
      TrainManager:ChangeState(TrainState.EventFinish)
      Train.StrikeDialogClose()
    end
    MainDataModel.SetTrainEventBasicId()
  else
    if json.consumables then
      PlayerData.TempCache.EventFinish = true
      TrainManager:LevelEventFinish()
      PlayerData.FreeCameraIndex = 1
      MainDataModel.SetCamera(PlayerData.FreeCameraIndex)
      PlayerData.TempCache.EventId = cfg.id
      PlayerData.TempCache.consumables = json.consumables
      TrainManager:ChangeState(TrainState.EventFinish)
      MainDataModel.SetTrainEventBasicId()
    elseif cfg.mod == "关卡事件" then
      PlayerData.TempCache.EventFinish = false
    else
      PlayerData.TempCache.EventFinish = true
      MainDataModel.SetTrainEventBasicId()
    end
    if cfg.mod == "污染点击事件" then
      if PlayerData.TempCache.AreaId ~= nil and PlayerData.pollute_areas[tostring(PlayerData.TempCache.AreaId)] ~= nil and PlayerData.TempCache.EventIndex ~= nil and PlayerData.pollute_areas[tostring(PlayerData.TempCache.AreaId)].click_level_events[tostring(PlayerData.TempCache.EventIndex)] == tostring(MainDataModel.TrainEventId) then
        PlayerData.Last_Chapter_Parms = {
          areaId = PlayerData.TempCache.AreaId,
          eventId = MainDataModel.TrainEventId,
          eventIndex = PlayerData.TempCache.EventIndex,
          type = "pollute"
        }
        PlayerData.BattleCallBackPage = "UI/Chapter/Battle_Dungeon"
      else
        PlayerData.BattleCallBackPage = ""
      end
      MainDataModel.SetTrainEventBasicId()
    elseif cfg.mod == "点击副本事件" then
      if PlayerData.TempCache.AreaId ~= nil and PlayerData.pollute_areas[tostring(PlayerData.TempCache.AreaId)] ~= nil and PlayerData.TempCache.EventIndex ~= nil and PlayerData.pollute_areas[tostring(PlayerData.TempCache.AreaId)].click_dungeon_events[tostring(PlayerData.TempCache.EventIndex)] == tostring(MainDataModel.TrainEventId) then
        local num = PlayerData:GetDungeonNum(PlayerData.TempCache.AreaId, PlayerData.TempCache.EventIndex)
        if num < cfg.countMax then
          PlayerData.Last_Chapter_Parms = {
            areaId = PlayerData.TempCache.AreaId,
            eventId = MainDataModel.TrainEventId,
            eventIndex = PlayerData.TempCache.EventIndex,
            type = "dungeon"
          }
          PlayerData.BattleCallBackPage = "UI/Chapter/Battle_Dungeon"
        else
          PlayerData.BattleCallBackPage = ""
        end
      else
        PlayerData.BattleCallBackPage = ""
      end
      MainDataModel.SetTrainEventBasicId()
    end
    PlayerData.TempCache.AreaId = nil
    PlayerData.TempCache.EventIndex = nil
    PlayerData.TempCache.Sid = nil
    PlayerData.TempCache.NextDistance = nil
  end
  if json.minus_durable then
    PlayerData.TempCache.minus_durable = json.minus_durable
    PlayerData:GetHomeInfo().readiness.repair.current_durable = PlayerData:GetHomeInfo().readiness.repair.current_durable - json.minus_durable
  end
end

local View = require("UIMainUI/UIMainUIView")

function Train.RushDelayComplete()
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  mainDataModel.SetIsRushClick(false)
  local mainController = require("UIMainUI/UIMainUIController")
  mainController.RushDelayComplete()
end

function Train.RushEnter()
  TrainManager:UpdateTrainAcceleratedSpeed(true)
  local mainController = require("UIMainUI/UIMainUIController")
  local MainDataModel = require("UIMainUI/UIMainUIDataModel")
  local isHave = TrainWeaponTag.IsWeaponedById(83100032)
  if isHave then
    MainDataModel.SetIsWeaponRushShow(false)
    MainDataModel.SetWeaponRushDuration(3)
    mainController.WeaponRush()
  end
  local value1 = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainAddSpeedBuff)
  if value1[1] == nil then
    return
  end
  local value2 = PlayerData:GetFactoryData(value1[1], "TrainWeaponSkillFactory").randomConstant
  if value2 <= 0 then
    return
  end
  MainDataModel.SetWeaponRushDuration(value2)
  MainDataModel.SetIsWeaponRushShow(true)
  mainController.WeaponRush()
end

function Train.RushLeave()
  Train.Rush(0, 0)
  TrainManager:UpdateTrainAcceleratedSpeed(false)
  local mainController = require("UIMainUI/UIMainUIController")
  local MainDataModel = require("UIMainUI/UIMainUIDataModel")
  MainDataModel.SetWeaponRushDuration(0)
  MainDataModel.SetIsWeaponRushShow(false)
  mainController.WeaponRush()
  mainController.WeaponRushOver()
end

function Train.Rush(remainTime, rushTime)
  local mainController = require("UIMainUI/UIMainUIController")
  mainController.Rushing(remainTime, rushTime)
end

local isSend = false
local isClick

function Train.Box(sid, boxId, index, isAuto)
  if isAuto then
    local user_info = PlayerData:GetUserInfo()
    if user_info.space_info.now_train_goods_num >= PlayerData.GetOverMaxTrainGoodsNum() then
      return
    end
  end
  if Train.WaitPickUpBoxList == nil then
    Train.WaitPickUpBoxList = {}
  end
  local strSID = tostring(sid)
  if Train.LastSID ~= strSID then
    if Train.LastSID ~= nil then
      Train.WaitPickUpBoxList[Train.LastSID] = nil
    end
    Train.LastSID = strSID
    Train.CanSendPickBox = true
    TimerHelper.Start("PickUpBoxUpdate", 0.02, Train.SendNet_PickBox)
  end
  if Train.WaitPickUpBoxList[strSID] == nil then
    Train.WaitPickUpBoxList[strSID] = {}
  end
  local distance = PlayerData:GetBoxDistanceByIndex(strSID, index + 1)
  if distance == nil or ListContainsValue(Train.WaitPickUpBoxList[strSID], distance) then
    return
  end
  table.insert(Train.WaitPickUpBoxList[strSID], distance)
  return
end

function Train.SendNet_PickBox()
  if not Train.CanSendPickBox or Train.LastSID == nil or #Train.WaitPickUpBoxList[Train.LastSID] == 0 then
    return
  end
  local distance = Train.WaitPickUpBoxList[Train.LastSID][1]
  local boxId, index = PlayerData:GetBoxIdByDistance(Train.LastSID, distance)
  local sid = tonumber(Train.LastSID)
  if sid == nil or boxId == nil or index == nil then
    return
  end
  Train.CanSendPickBox = false
  index = index - 1
  Net:SendProto("events.happen", function(json)
    print_r(json)
    UIManager:Open("UI/MainUI/BoxGet", Json.encode(json.reward))
    TrainManager:DeleteBoxByIndex(index)
    local mainController = require("UIMainUI/UIMainUIController")
    mainController.SetSpeedAddShow()
    table.remove(Train.WaitPickUpBoxList[Train.LastSID], 1)
    Train.CanSendPickBox = true
  end, boxId, sid, index, function()
    table.remove(Train.WaitPickUpBoxList[Train.LastSID], 1)
    Train.CanSendPickBox = true
  end)
end

function Train.KeyDrive()
end

function Train.KeyRush()
end

function Train.KeyStop()
end

function Train.KeyAstern()
end

function Train.KeyBattleEventFinish()
  local MainDataModel = require("UIMainUI/UIMainUIDataModel")
  local mainController = require("UIMainUI/UIMainUIController")
  if MainDataModel.TrainEventId then
    if not Train.IsKeyEvent then
      local levelData = PlayerData:GetFactoryData(MainDataModel.TrainLevelId, "LevelFactory")
      local isHaveRole = #levelData.levelRoleList > 0
      Net:SendProto("battle.start_battle", function(json)
        PlayerData.TempCache.GuideNoUpdateLimitData[EnumDefine.GuideNoUpdateLimitDataEnum.LevelId] = levelData.levelId
        PlayerData.FreeCameraIndex = 1
        PlayerData.TempCache.EventIndex = nil
        PlayerData.TempCache.Sid = nil
        PlayerData.TempCache.NextDistance = nil
        PlayerData.TempCache.AreaId = nil
        MainDataModel.SetCamera(PlayerData.FreeCameraIndex)
        if json.levelUid ~= nil then
          PlayerData.BattleInfo.levelUid = json.levelUid
        end
        local levelCA = PlayerData:GetFactoryData(levelData.levelId, "LevelFactory")
        if PlayerData.ServerData.record_level == nil then
          PlayerData.ServerData.record_level = {}
        end
        if levelCA ~= nil then
          PlayerData.ServerData.record_level[levelCA.mod] = levelData.levelId
        end
        PlayerData.LevelData = levelCA
        Net:SendProto("battle.end_battle", function(json)
          PlayerData.BattleInfo.BattleResult = {isWin = true}
          Train.EventBattleFinish(json)
          local behaviour = require("UIMainUI/UIMainUILuaBehaviour")
          behaviour[1].deserialize()
          TrainManager:InitPolluteSkin()
          mainController.StrikeShow(false)
          if MainDataModel.CurSceneName == MainDataModel.SceneNameEnum.Home and PlayerData.TempCache.MainUIShowState == 1 then
            View.self:StartC(LuaUtil.cs_generator(function()
              MainManager:SetTrainViewFilter(30, true)
              coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
              local cb = function()
                UIManager:Pause(false)
                CBus:ChangeScene("Main")
                PlayerData:SetTargetFrameRate()
              end
              CommonTips.OpenLoading(cb, "UI/Home/HomeLoading")
            end))
          end
          if PlayerData.pollute_areas == nil or table.count(PlayerData.pollute_areas) == 0 then
            Net:SendProto("unification.world_pollute", function()
              PlayerData:GetPolluteTurntable(1)
            end)
          else
            PlayerData:GetPolluteTurntable(1)
          end
          Train.IsKeyEvent = false
        end, json.levelUid, 1, nil, function()
          Train.IsKeyEvent = false
        end, 0, 1)
      end, tostring(MainDataModel.TrainLevelId), tostring(MainDataModel.TrainEventId), tostring(0), isHaveRole and 0 or 1, "", 1, PlayerData.TempCache.EventIndex, PlayerData.TempCache.Sid, nil, function()
        Train.IsKeyEvent = false
      end, nil, PlayerData.TempCache.NextDistance, PlayerData.TempCache.AreaId)
    end
    Train.IsKeyEvent = true
  end
end

function Train.Arriving()
  local mainController = require("UIMainUI/UIMainUIController")
  mainController.ChangeDriveBtnState()
  mainController:RunBtnState(false)
end

function Train.TrailerStop()
  local MainDataModel = require("UIMainUI/UIMainUIDataModel")
  local mainController = require("UIMainUI/UIMainUIController")
  Net:SendProto("station.arrive", function(json)
    PlayerData:GetHomeInfo().station_info = json.station_info
    PlayerData.TempCache.IsTrailer = true
    MainDataModel.justArrived = true
    MainDataModel.GetCurShowSceneInfo(MainDataModel.TrailerCityId)
    TradeDataModel.CurStayCity = MainDataModel.TrailerCityId
    TradeDataModel.EndCity = TradeDataModel.CurStayCity
    MainDataModel.TrailerCityId = nil
    TrainCameraManager:SetPostProcessing(1, MainDataModel.CurShowSceneInfo.postProcessingPath)
    TrainManager:TravelOver()
    TradeDataModel.CurRemainDistance = 0
    PlayerData.showPosterGirl = 1
    mainController.SetSpeedShow(0)
    mainController.ArriveRefreshShow(json)
    mainController:InitCheDengLight()
    if json.furniture then
      for i, v in pairs(json.furniture) do
        PlayerData:GetHomeInfo().furniture[i] = v
      end
    end
    PlayerData:ClearPollute()
    if json.drive_distance then
      PlayerData:GetHomeInfo().drive_distance = json.drive_distance
    end
    if json.drive_time then
      PlayerData:GetHomeInfo().drive_time = json.drive_time
    end
    mainController.ShowEndActive(false)
    if json.fatigue then
      UIManager:Open("UI/Common/FatigueAddTips", tostring(json.fatigue))
    end
    local MapController = require("UIHome/UIHomeMapController")
    MapController:RefreshStationPos()
    MapController:RefreshViewToTrain()
    mainController.ShowEndActive(false)
    mainController.StrikeShow(false)
    mainController:ShowPosterGirl(false)
    View.Group_Common.Img_DialogBox:SetActive(false)
    MapNeedleData.ResetData()
  end, MainDataModel.TrailerCityId, 1)
end

function Train.CloseLevelEventIndexUI()
  if PlayerData.TempCache.EventIndex then
    TrainManager:CloseEventIndexUI(PlayerData.TempCache.EventIndex)
  end
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  View.Group_Common.Btn_ClickFight.self:SetActive(false)
end

function Train.ClickLevelEvent(eventId, index, areaId, key, gameObject)
  print_r("常驻点击事件", eventId, index, areaId, gameObject, key)
  gameObject:SetActive(true)
  if PlayerData.TempCache.EventIndex and PlayerData.TempCache.EventIndex == key then
    return
  end
  local Show = gameObject.transform:Find("Show").gameObject
  Show:SetActive(true)
  Train.CloseLevelEventIndexUI()
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  local event = PlayerData:GetFactoryData(eventId)
  local areaCA = PlayerData:GetFactoryData(areaId)
  local levelId = event.levelId
  mainDataModel.SetTrainEventBasicId(eventId, levelId)
  PlayerData.TempCache.AreaId = areaId
  PlayerData.TempCache.EventIndex = key
  local t = string.split(PlayerData.TempCache.EventIndex, ":")
  local txt_lv = ""
  if areaCA.ClickLevelList and table.count(areaCA.ClickLevelList) then
    for k, v in pairs(areaCA.ClickLevelList) do
      if tonumber(v.id) == tonumber(t[1]) then
        txt_lv = "Lv:" .. math.floor((v.levelLvMax + v.levelLvMin) / 2)
        break
      end
    end
  end
  View.Group_Common.Btn_ClickFight.self:SetActive(true)
  View.Group_Common.Btn_ClickFight.Txt_Name:SetText(event.name)
  View.Group_Common.Btn_ClickFight.Img_Icon:SetSprite(event.eventHeadPath)
  View.Group_Common.Btn_ClickFight.Txt_Lv:SetText(txt_lv)
end

function Train.Back()
  CommonTips.OpenArriveTip(true)
end

function Train.StrikeReadyStep1(eventId, lineId)
  local mainController = require("UIMainUI/UIMainUIController")
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  mainController.ShowWarning(false)
  mainController:ShowMBDurability(true)
  mainController.ShowStrikeTip(true, false)
  mainController.MainLineEventShow(eventId, true, true)
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  mainDataModel.SetTrainEventBasicId(eventId, event.levelId, lineId)
  local percent = mainDataModel.GetStrikeSuccessPercent(eventId, lineId)
  CommonTips.OpenStrikeTip(80601500, percent)
end

function Train.StrikeReadyStep2(eventId, lineId)
  local mainController = require("UIMainUI/UIMainUIController")
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  local percent = mainDataModel.GetStrikeSuccessPercent(eventId, lineId)
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  mainDataModel.SetTrainEventBasicId(eventId, event.levelId, lineId)
  mainController.ShowWarning(false)
  mainController.ShowStrikeTip(false, true, percent)
  CommonTips.OpenStrikeTip(80601895, percent)
end

function Train.StrikeReadyStep3(eventId, lineId)
  local mainController = require("UIMainUI/UIMainUIController")
  mainController:ShowMBDurability(true)
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  local percent = mainDataModel.GetStrikeSuccessPercent(eventId, lineId)
  mainController.ShowWarning(false)
  mainController.ShowStrikeTip(false, true, percent)
  CommonTips.OpenStrikeTip(80601894, percent)
end

function Train.StrikeStart(eventId, lineId)
  local mainController = require("UIMainUI/UIMainUIController")
  mainController.MainLineEventShow(eventId, false, true)
  mainController.StrikeStart()
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  local percent = mainDataModel.GetStrikeSuccessPercent(eventId, lineId)
  mainController.ShowStrikeTip(false, true, percent)
  CommonTips.OpenStrikeTip(80601503, percent)
end

function Train.Strike(sid, eventId, speed)
  PlayerData.TempCache.EventFinish = true
  local internal = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
  local _currLevelEvent = CS.FRef.getProperty(internal.EventCtrl.LevelCtrl, "_currLevelEvent")
  if _currLevelEvent ~= nil then
    _currLevelEvent:UnLoadRes()
  end
  speed = math.floor(speed)
  local mainController = require("UIMainUI/UIMainUIController")
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  mainController.StrikeShow(false)
  mainController.StrikeSuccess(true)
  mainController.ChangeDriveBtnState()
  Net:SendProto("events.assault", function(json)
    local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
    if json.minus_durable and json.minus_durable == 0 then
      CommonTips.OpenStrikeTip(80601518, 0, true)
    else
      PlayerData:GetHomeInfo().readiness.repair.current_durable = PlayerData:GetHomeInfo().readiness.repair.current_durable - json.minus_durable
      CommonTips.OpenStrikeTip(80601504, {
        json.minus_durable,
        PlayerData:GetHomeInfo().readiness.repair.current_durable
      }, true)
    end
    TrainManager:ChangeStrikeState(StrikeState.Finish)
    TrainManager:LevelEventFinish()
    mainDataModel.SetTrainEventBgmId()
    mainDataModel.SetTrainEventBasicId()
    mainController.PlayTrainBgm()
    mainController:RunBtnState(true)
    local strike = PlayerData.GetStrike()
    if strike.id then
      local cfg = PlayerData:GetFactoryData(strike.id, "HomeWeaponFactory")
      CommonTips.OpenFatigueTip(math.floor(cfg.WeaponTired - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReduceEscapeEnergy) + 0.1))
    end
    PlayerData.FreeCameraIndex = 1
    mainDataModel.SetCamera(PlayerData.FreeCameraIndex)
    mainController.ShowStrikeTip(false, false)
    mainController:ShowMBDurability(false)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
  end, eventId, sid, speed, function(json)
    PlayerData.TempCache.EventFinish = false
    TrainManager:ChangeStrikeState(StrikeState.None)
    local internal = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
    local _currLevelEvent = CS.FRef.getProperty(internal.EventCtrl.LevelCtrl, "_currLevelEvent")
    if _currLevelEvent ~= nil then
      _currLevelEvent:LoadRes()
    end
    CommonTips.OpenStrikeTip(80601502, nil, true)
    TrainManager:ChangeState(TrainState.Event)
    mainController:ShowMBDurability(false)
  end)
end

function Train.StrikeFail(eventId, isLoss)
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  if isLoss then
    CommonTips.OpenStrikeTip(event.textLossId, 0)
  elseif event.isStrike then
    CommonTips.OpenStrikeTip(event.levelTextId, 0)
  else
    if event.isShowTips == false then
      return
    end
    if UIManager:GetCurrentPanelURL() == "UI/MainUI/MainUI" then
      CommonTips.OpenStrikeTip(event.levelTextId, 0)
    end
  end
end

function Train.StrikeDialogUpdate(time, successRatio)
  local controller = require("UIDialogBox_Tip/UIDialogBbox_Controller")
  successRatio = math.min(99, math.max(1, math.floor(successRatio * 100)))
  controller.Update(time, successRatio)
end

function Train.StrikeDialogClose()
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    local controller = require("UIDialogBox_Tip/UIDialogBox_Controller")
    controller.Close()
    local mainController = require("UIMainUI/UIMainUIController")
    mainController.StrikeShow(false)
  end
end

function Train.SetRushEffectState(state)
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  local mainController = require("UIMainUI/UIMainUIController")
  mainDataModel.SetIsRushing(state)
  mainController.SetRushEffectState()
end

function Train.PolluteClickEvent(eventId, index, areaId)
  print_r("点击事件", eventId, index)
  print_r(string.format("Pollute事件id：%d, 事件索引：%d， 区域id：%d", eventId, index, areaId))
  UIManager:Open("UI/Chapter/Battle_Dungeon", Json.encode({
    eventId = eventId,
    eventIndex = index,
    areaId = areaId,
    type = "pollute"
  }))
end

function Train.DungeonClickEvent(eventId, eventIndex, areaId)
  print_r(string.format("dungeon事件id：%d, 事件索引：%d， 区域id：%d", eventId, eventIndex, areaId))
  UIManager:Open("UI/Chapter/Battle_Dungeon", Json.encode({
    eventId = eventId,
    eventIndex = eventIndex,
    areaId = areaId,
    type = "dungeon"
  }))
end

function Train.TrainStrikeDisTrigger(eventId)
  local mainController = require("UIMainUI/UIMainUIController")
  mainController.ShowWarning()
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  local mainDataModel = require("UIMainUI/UIMainUIDataModel")
  mainDataModel.SetCamera(2)
  mainDataModel.SetTrainEventBgmId(event.bgmId)
  mainController.PlayTrainBgm()
end

function Train.Backing()
  local mainController = require("UIMainUI/UIMainUIController")
  mainController.ChangeDriveBtnState()
  mainController:RunBtnState(false)
end

function Train.GetTrainAcceleratedSpeedChange(type, isRush)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if type == 1 then
    local speedAddLv = PlayerData:GetHomeInfo().expedite_lv or 1
    local speedAdd = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStartAddSpeed)[2]
    print_r(speedAdd)
    speedAdd = speedAdd + math.floor(homeConfig.speedUpList[speedAddLv].Num + 0.5)
    return speedAdd / homeConfig.speedRatio
  elseif type == 2 then
    local speedReduceLv = PlayerData:GetHomeInfo().brake_lv or 1
    local speedReduce = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStoptAddSpeed)[2]
    speedReduce = speedReduce + math.floor(homeConfig.slowDownList[speedReduceLv].Num + 0.5)
    return speedReduce / homeConfig.speedRatio
  end
  return 0
end

function Train.GetStrikePower()
  local power = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainWeaponImpact)[2]
  return power
end

function Train.GetExtraBoxClickDistance()
  local distance = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.BoxClickDistance)[2]
  return distance
end

function Train.GetExtraMonsterClickDistance()
  local distance = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.MonsterClickDistance)[2]
  return distance
end

function Train.GetIsAutoPickGoods()
  local isAutoPick = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AutoPickGoods)
  return isAutoPick
end

return Train
