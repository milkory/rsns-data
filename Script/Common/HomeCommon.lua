local module = {}
local setResourcesElementShow = function(element, curValue, maxValue)
  element.Txt_Num:SetText(curValue .. "/" .. maxValue)
  element.Img_PB:SetFilledImgAmount(curValue / maxValue)
end

function module.AutoSubMoveEnergy(changeCb)
  if PlayerData:GetUserInfo().move_energy == nil then
    return
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if PlayerData:GetUserInfo().move_energy <= 0 then
    return
  end
  local onceTime = homeConfig.homeEnergyAddCD
  local onceAdd = -homeConfig.homeEnergyAdd
  if TimeUtil:GetServerTimeStamp() >= PlayerData:GetUserInfo().move_energy_time + onceTime then
    PlayerData:GetUserInfo().move_energy_time = PlayerData:GetUserInfo().move_energy_time + onceTime
    PlayerData:GetUserInfo().move_energy = PlayerData:GetUserInfo().move_energy + onceAdd
    if PlayerData:GetUserInfo().move_energy < 0 then
      PlayerData:GetUserInfo().move_energy = 0
    end
    changeCb()
  end
end

function module.SetMoveEnergyElement(element)
  local curEnergy = PlayerData:GetUserInfo().move_energy
  setResourcesElementShow(element, curEnergy, module.GetMaxHomeEnergy())
end

function module.SetEnergyElement(element)
  local user_info = PlayerData:GetUserInfo()
  setResourcesElementShow(element, user_info.energy or 0, user_info.max_energy or 0)
end

function module.SetLoadageElement(element)
  local user_info = PlayerData:GetUserInfo()
  setResourcesElementShow(element, user_info.space_info.now_train_goods_num or 0, PlayerData.GetMaxTrainGoodsNum())
end

function module.SetPassengerElement(element)
  setResourcesElementShow(element, PlayerData:GetCurPassengerNum() or 0, PlayerData:GetMaxPassengerNum() or 0)
end

function module.SetTradeElement(element)
  local curTotalTradeExp, totalTradeExp = module.GetTradeExpValue()
  setResourcesElementShow(element, curTotalTradeExp, totalTradeExp)
  local lv = PlayerData:GetHomeInfo().trade_lv
  if element.Txt_Lv then
    element.Txt_Lv:SetText(lv)
  end
end

function module.SetReputationElement(element, stationId, isShowRedPoint)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = serverStation.rep_lv or 0
  element.Txt_Grade:SetText(string.format(GetText(80600542), curLv))
  local curTotalRep, totalRep = module.GetReputationValue(stationId)
  if totalRep <= curTotalRep then
    element.Txt_Num:SetText(curTotalRep)
    element.Img_PB:SetFilledImgAmount(1)
  else
    element.Txt_Num:SetText(curTotalRep .. "/" .. totalRep)
    element.Img_PB:SetFilledImgAmount(curTotalRep / totalRep)
  end
  if isShowRedPoint == nil then
    isShowRedPoint = true
  end
  element.Img_RedPoint:SetActive(isShowRedPoint and not module.IsAllRepValueGet(stationId))
end

function module.ClickReputationBtn(stationId, posX, posY, yesCb)
  local t = {}
  t.stationId = stationId
  if posX ~= nil and posY ~= nil then
    t.posX = posX
    t.posY = posY
  end
  UIManager:Open(UIPath.UIHomeReputation, Json.encode(t), yesCb)
end

function module.GetReputationValue(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = serverStation.rep_lv or 0
  local curReputationValue = serverStation.rep_num or 0
  local rewardList = stationCA.repRewardList
  local totalValue = 0
  for i = 1, curLv do
    totalValue = totalValue + rewardList[i].repNum
  end
  local curTotalRep = 0
  if rewardList[curLv + 1] ~= nil then
    curTotalRep = totalValue
    curTotalRep = curTotalRep + rewardList[curLv + 1].repNum
  end
  if curLv + 1 == rewardList then
    curTotalRep = 0
  end
  totalValue = totalValue + curReputationValue
  totalValue = math.modf(totalValue)
  return totalValue, math.modf(curTotalRep)
end

function module.GetTradeExpValue()
  local curLv = PlayerData:GetHomeInfo().trade_lv
  local curExp = PlayerData:GetHomeInfo().exp
  local tradeExpConfig = PlayerData:GetFactoryData(99900016, "ConfigFactory")
  local tradeList = tradeExpConfig.expList
  return curExp, tradeList[curLv].needExp
end

function module.GetCurLvRepData(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = (serverStation.rep_lv or 0) + 1
  local rewardList = stationCA.repRewardList or {}
  return rewardList[curLv]
end

function module.GetRepRewardList(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  return stationCA.repRewardList or {}
end

function module.GetRepLv(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  return PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv
end

function module.TimeCheckRefreshStationInfo(force, cb)
  local refreshFunc = function()
    Net:SendProto("station.refresh", function(json)
      for k, v in pairs(json.stations) do
        for k1, v1 in pairs(v) do
          PlayerData:GetHomeInfo().stations[k][k1] = v1
        end
      end
      if cb ~= nil then
        cb()
      end
    end)
  end
  local curTime = TimeUtil:GetServerTimeStamp()
  if force or PlayerData.TempCache.stationRefresh == nil then
    PlayerData.TempCache.stationRefresh = curTime
    refreshFunc()
    return
  else
    local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
    local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
    local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
    local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s, PlayerData.TempCache.stationRefresh)
    if curTime >= targetTime then
      PlayerData.TempCache.stationRefresh = curTime
      refreshFunc()
      return
    end
  end
  if cb ~= nil then
    cb()
  end
end

function module.OpenMoveEnergyUseItem(cb)
  local itemCA = PlayerData:GetFactoryData(11400064, "ItemFactory")
  local homeEnergyItemList = PlayerData:GetFactoryData(99900014).homeEnergyItemList
  local data = {}
  data.idList = {}
  for i, v in ipairs(homeEnergyItemList) do
    table.insert(data.idList, v.id)
  end
  table.insert(data.idList, 11400005)
  UIManager:Open("UI/MoveEnergy/MoveEnergy", Json.encode(data), cb)
end

function module.GetCurShowSceneInfo(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local stateInfo = module.GetCityStateInfo(stationId)
  if stateInfo == nil then
    stateInfo = stationCA.cityStateList[1]
  end
  local sceneInfo
  local curDevDegree = PlayerData:GetHomeInfo().dev_degree[tostring(stationId)].dev_degree or 0
  local sceneCA = PlayerData:GetFactoryData(stateInfo.sceneId, "ListFactory")
  for k, v in pairs(sceneCA.stationSceneList) do
    if curDevDegree >= v.dev then
      sceneInfo = v
    end
  end
  if sceneInfo == nil then
    sceneInfo = sceneCA.stationSceneList[1]
  end
  local CurShowSceneInfo = {}
  CurShowSceneInfo.stationScene = sceneInfo.stationScene
  CurShowSceneInfo.postProcessingPath = sceneInfo.postProcessingPath
  CurShowSceneInfo.sceneWidth = sceneInfo.sceneWidth
  CurShowSceneInfo.bgmId = sceneInfo.bgmId
  CurShowSceneInfo.sceneGroup = sceneInfo.sceneGroup
  return CurShowSceneInfo
end

function module.GetMaxHomeEnergy()
  local userExpConfig = PlayerData:GetFactoryData(99900004, "ConfigFactory")
  local curLv = PlayerData:GetPlayerLevel()
  local count = #userExpConfig.expList
  if curLv > count then
    curLv = count
  end
  return userExpConfig.expList[curLv].homeEnergyMax + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseEnergyLimited)
end

function module.IsAllConstructionValueGet(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local stateInfo = module.GetCityStateInfo(stationId)
  local listCA = PlayerData:GetFactoryData(stateInfo.cityMapId, "ListFactory")
  if listCA.isShowConstruct then
    local ConstructMaxNum = 0
    local ConstructNowNum = 0
    local ConstructNowCA = {}
    local StationList = PlayerData:GetHomeInfo().stations[tostring(stationId)]
    local StationState = StationList.state
    for k, v in pairs(StationList.construction) do
      ConstructNowNum = ConstructNowNum + v.proportion
    end
    local construction_count = 0
    for i = 1, #stationCA.constructStageList do
      local row = stationCA.constructStageList[i]
      ConstructMaxNum = ConstructMaxNum + row.constructNum
      ConstructNowCA = row
      construction_count = i
      if row.state and row.state ~= -1 and ConstructNowNum >= ConstructMaxNum and StationState < row.state then
        StationState = row.state
        PlayerData:GetHomeInfo().stations[tostring(stationId)].state = row.state
      end
      if ConstructNowNum <= ConstructMaxNum then
        break
      end
    end
    local row_server = StationList.construction[construction_count]
    local stageRewardList = PlayerData:GetFactoryData(ConstructNowCA.id).stageRewardList
    local count = 0
    for k, v in pairs(stageRewardList) do
      if ConstructNowNum >= v.construct and row_server.rec_index[k] == nil then
        count = count + 1
      end
    end
    if count ~= 0 then
      return true
    end
    return false
  end
end

function module.IsAllRepValueGet(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = serverStation.rep_lv or 0
  local isGet = {}
  if serverStation.rep_reward ~= nil then
    for k, v in pairs(serverStation.rep_reward) do
      isGet[v] = 1
    end
  end
  for i = 1, curLv do
    if not isGet[i] then
      return false
    end
  end
  return true
end

function module.GetCityStateInfo(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local curStationServerData = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curState = curStationServerData.state or 0
  for k, v in pairs(stationCA.cityStateList) do
    if v.state == curState then
      return v
    end
  end
  return nil
end

return module
