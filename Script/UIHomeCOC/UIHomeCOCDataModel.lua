local DataModel = {
  StationId = 0,
  BuildingId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "FFFFFF",
  OrderInfo = {},
  NextDayTime = 0,
  OrderAccpetCount = 0,
  CurSelectedOrderIdx = 0,
  NextRefreshTime = 0,
  MaxSpace = 0,
  CurUseSpace = 0,
  OrderTimeReach = false,
  IsMainScene = false,
  IsHomeReturn = false,
  NPCDialogEnum = {
    enterText = "enterText",
    talkText = "talkText",
    questListText = "questListText",
    questListNullText = "questListNullText",
    acceptQuestText = "acceptQuestText",
    cancelQuestText = "cancelQuestText",
    addQuestSuccessText = "addQuestSuccessText",
    notEnoughText = "notEnoughText",
    addQuestFailText = "addQuestFailText"
  },
  IconPath = {
    Buy = "UI\\HomeCOC\\coc_icon_buy",
    Send = "UI\\HomeCOC\\coc_icon_send",
    Passenger = "UI\\HomeCOC\\coc_icon_passenger"
  },
  TypeTxt = {
    Buy = 80602118,
    Send = 80602117,
    Passenger = 80602119
  },
  CacheEventList = {}
}

function DataModel.Init()
  DataModel.MaxSpace = PlayerData.GetMaxTrainGoodsNum()
  DataModel.CurUseSpace = PlayerData:GetUserInfo().space_info.now_train_goods_num
end

function DataModel.RefreshAllOrderInfo(quests)
  DataModel.OrderAccpetCount = 0
  DataModel.OrderInfo = {}
  for k, v in pairs(quests) do
    for k1, v1 in pairs(v) do
      local questCA = PlayerData:GetFactoryData(k1, "QuestFactory")
      local photoFactory = PlayerData:GetFactoryData(questCA.client, "ProfilePhotoFactory")
      local t = {}
      t.id = tonumber(k1)
      t.isSend = questCA.cocQuestType == "Send"
      t.isBuy = questCA.cocQuestType == "Buy"
      t.isPassenger = questCA.cocQuestType == "Passenger"
      t.isInitQuest = questCA.isInitQuest
      t.type = k
      t.name = questCA.name
      t.goodsList = questCA.goodsList
      t.passengerList = questCA.passengerList
      t.space = 0
      if t.isSend then
        for k2, v2 in pairs(t.goodsList) do
          local goodsCA = PlayerData:GetFactoryData(v2.id, "HomeGoodsFactory")
          t.space = t.space + goodsCA.space * v2.num
          t.space = math.ceil(t.space)
        end
      elseif t.isPassenger then
        for k2, v2 in pairs(t.passengerList) do
          t.space = t.space + v2.num
          t.space = math.ceil(t.space)
        end
      end
      t.rewardsList = questCA.rewardsList
      t.reputationList = questCA.reputationList
      t.rewards = {}
      for k, v in ipairs(questCA.rewardsList) do
        table.insert(t.rewards, v)
      end
      if questCA.reputationList then
        for k, v in ipairs(questCA.reputationList) do
          table.insert(t.rewards, v)
        end
      end
      t.startStation = questCA.startStation
      t.endStation = v1.sid or questCA.endStationList[1].id
      t.endStation = tonumber(t.endStation)
      t.detail = questCA.story
      t.giveUp = questCA.giveUp
      t.clientIcon = photoFactory.imagePath
      t.clientName = photoFactory.name
      t.configLimitTime = questCA.timeLimit
      local isLimit = 0 < questCA.timeLimit and 0 < v1.time
      t.limitTime = isLimit and v1.time + questCA.timeLimit * 3600 or -1
      local isAccept = v1.time ~= -1
      t.state = isAccept and 1 or 0
      if isAccept then
        DataModel.OrderAccpetCount = DataModel.OrderAccpetCount + 1
      end
      t.showTimeText = DataModel.GetTimeShowText(t)
      table.insert(DataModel.OrderInfo, t)
    end
  end
  DataModel.SortOrder()
end

function DataModel.GetTimeShowText(t)
  local text = ""
  if t.configLimitTime > 0 then
    local deltaTime = t.configLimitTime * 3600
    local isAccpet = false
    if 0 < t.limitTime then
      local curTime = TimeUtil:GetServerTimeStamp()
      deltaTime = t.limitTime - curTime
      isAccpet = true
    end
    if 0 <= deltaTime then
      local remain1 = math.modf(deltaTime / 86400)
      local remain2 = deltaTime % 86400
      if 0 < remain1 then
        local textId = isAccpet and 80600489 or 80600506
        text = string.format(GetText(textId), remain1)
      else
        remain1 = math.modf(remain2 / 3600)
        remain2 = remain2 % 3600
        if 0 < remain1 then
          local textId = isAccpet and 80600490 or 80600507
          text = string.format(GetText(textId), remain1)
        else
          remain1 = math.modf(remain2 / 60)
          remain2 = remain2 % 60
          if 0 < remain1 then
            local textId = isAccpet and 80600491 or 80600508
            text = string.format(GetText(textId), remain1)
          else
            text = string.format(GetText(80600494))
          end
        end
      end
    end
  end
  return text
end

function DataModel.SortOrder()
  table.sort(DataModel.OrderInfo, function(a, b)
    if a.state == 1 and b.state == 0 then
      return false
    elseif a.state == 0 and b.state == 1 then
      return true
    else
      return a.id < b.id
    end
  end)
end

function DataModel.ReceiveOrder(info, cb)
  local space = 0
  if info.isSend then
    for k, v in pairs(info.goodsList) do
      local goodsCA = PlayerData:GetFactoryData(v.id, "HomeGoodsFactory")
      space = space + v.num * goodsCA.space
    end
  elseif info.isPassenger then
    for k, v in pairs(info.passengerList) do
      space = space + v.num
    end
  end
  if info.isPassenger then
    if space + PlayerData:GetCurPassengerNum() > PlayerData:GetMaxPassengerNum() then
      CommonTips.OpenTips("载客量不足")
      return
    end
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    if PosClickHandler.GetCoachDirtyPercent() < homeConfig.cleantwo then
      CommonTips.OpenFlierConditionTips({
        showType = EnumDefine.FlierConditionShowType.showNeedClean,
        stationId = DataModel.StationId
      })
      return
    end
  elseif info.isSend and not info.isInitQuest and space + DataModel.CurUseSpace > DataModel.MaxSpace then
    CommonTips.OpenTips(80600284)
    return
  end
  Net:SendProto("station.get_quest", function(json)
    if info.isSend then
      DataModel.CurUseSpace = DataModel.CurUseSpace + space
      for k, v in pairs(info.goodsList) do
        if PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] == nil then
          PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] = {}
          PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = 0
        end
        local num = PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num
        PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = num + v.num
      end
    elseif info.isPassenger then
      local psgData = require("UIPassenger/UIPassengerDataModel")
      psgData.RefreshPassenger(json.passenger, json.furniture)
    end
    local addTime = 0
    if 0 < info.configLimitTime then
      addTime = info.configLimitTime * 3600
    end
    local curTime = TimeUtil:GetServerTimeStamp()
    if not info.isSend then
      info.limitTime = curTime + addTime
    end
    info.state = 1
    info.showTimeText = DataModel.GetTimeShowText(info)
    PlayerData:GetHomeInfo().stations[tostring(info.startStation)].quests[info.type][tostring(info.id)].time = curTime
    if info.isBuy then
      local goodTable = {}
      for k, v in pairs(info.goodsList) do
        goodTable[tostring(v.id)] = 0
      end
      PlayerData:GetHomeInfo().stations[tostring(info.startStation)].quests[info.type][tostring(info.id)].info = goodTable
    end
    DataModel.OrderAccpetCount = DataModel.OrderAccpetCount + 1
    cb()
    QuestTrace.AcceptQuest(info.id)
  end, info.id)
end

function DataModel.CancelOrder(info, cb)
  if not info.giveUp then
    CommonTips.OpenTips(80601261)
    return
  end
  if info.state == 1 then
    Net:SendProto("station.reset_quest", function(json)
      info.state = 0
      info.limitTime = -1
      info.showTimeText = DataModel.GetTimeShowText(info)
      PlayerData:GetHomeInfo().stations[tostring(info.startStation)].quests[info.type][tostring(info.id)].time = -1
      PlayerData:GetHomeInfo().stations[tostring(info.startStation)].quests[info.type][tostring(info.id)].info = -2
      if info.isSend then
        DataModel.CalcRemoveInfoGoods(info, false)
      end
      local psgData = require("UIPassenger/UIPassengerDataModel")
      psgData.RefreshPassenger(json.passenger, json.furniture)
      cb()
      QuestTrace.CancelQuest(info.id)
    end, info.id)
  end
end

function DataModel.CompleteOrder(info, cb)
  if info.state == 1 then
    Net:SendProto("station.complete_quest", function(json)
      for k, v in pairs(info.goodsList) do
        local goodsCA = PlayerData:GetFactoryData(v.id, "HomeGoodsFactory")
        DataModel.CurUseSpace = DataModel.CurUseSpace - goodsCA.space * v.num
      end
      for k, v in pairs(DataModel.OrderInfo) do
        if v.id == info.id then
          table.remove(DataModel.OrderInfo, k)
          break
        end
      end
      for k, v in pairs(info.goodsList) do
        if PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] ~= nil then
          local num = PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num
          num = num - v.num
          if num <= 0 then
            PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] = nil
          else
            PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = num
          end
        end
      end
      DataModel.OrderAccpetCount = DataModel.OrderAccpetCount - 1
      cb()
      QuestTrace.CompleteQuestOne(info.id)
      CommonTips.OpenQuestsCompleteTip({
        [1] = info.id
      })
    end, info.id)
  end
end

function DataModel.CalcRemoveInfoGoods(info, isRemove)
  for k, v in pairs(info.goodsList) do
    local goodsCA = PlayerData:GetFactoryData(v.id, "HomeGoodsFactory")
    DataModel.CurUseSpace = DataModel.CurUseSpace - goodsCA.space * v.num
  end
  if isRemove then
    for k, v in pairs(DataModel.OrderInfo) do
      if v.id == info.id then
        table.remove(DataModel.OrderInfo, k)
        break
      end
    end
  end
  if info.isSend then
    for k, v in pairs(info.goodsList) do
      if PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] ~= nil then
        local num = PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num
        num = num - v.num
        if num <= 0 then
          PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] = nil
        else
          PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = num
        end
      end
    end
  end
  DataModel.OrderAccpetCount = DataModel.OrderAccpetCount - 1
end

function DataModel.GetRevecivedOrderCount()
  local count = 0
  for k, v in pairs(DataModel.OrderInfo) do
    count = count + (v.state == 2 and 1 or 0)
  end
  return count
end

function DataModel.InitDayRefreshTime()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  DataModel.NextRefreshTime = targetTime
end

return DataModel
