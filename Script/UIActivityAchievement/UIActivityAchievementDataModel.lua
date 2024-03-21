local DataModel = {}
DataModel.AchieveType = {Trade = 1, Battle = 2}
DataModel.defaultType = 1
DataModel.achieveType = 1
DataModel.addProfit = 100
DataModel.onceProfit = 100
DataModel.achieveTradeData = {}
DataModel.achieveBattleData = {}

function DataModel.InitData()
  DataModel.achieveType = nil
  DataModel.defaultType = DataModel.AchieveType.Trade
  DataModel.addProfit = 100
  DataModel.onceProfit = 100
  DataModel.achieveTradeData = {}
  DataModel.achieveBattleData = {}
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  DataModel.achieveTradeData = activityCfg.tradeTypeList
  DataModel.achieveBattleData = activityCfg.battleList
  DataModel.addProfit = DataModel.GetProfit("addProfit")
  DataModel.onceProfit = DataModel.GetProfit("onceProfit")
end

function DataModel.GetRedPointStateByType(type)
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local achievements = {}
  if type == DataModel.AchieveType.Trade then
    for i, trade in pairs(activityCfg.tradeTypeList) do
      local cfg = PlayerData:GetFactoryData(trade.typeId, "ListFactory")
      for i, v in pairs(cfg.achievementList) do
        table.insert(achievements, v.id)
      end
    end
  elseif type == DataModel.AchieveType.Battle then
    for i, v in pairs(activityCfg.battleList) do
      table.insert(achievements, v.missionId)
    end
  end
  for i, id in pairs(achievements) do
    local state = PlayerData.GetQuestState(id)
    if state == EnumDefine.EQuestState.Finish then
      return true
    end
  end
  return false
end

function DataModel.GetRedPointState()
  return DataModel.GetRedPointStateByType(DataModel.AchieveType.Trade) and DataModel.GetRedPointStateByType(DataModel.AchieveType.Battle)
end

function DataModel.GetProgressInfo()
  local finishNum = 0
  local totalNum = 0
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local achievements = {}
  for i, trade in pairs(activityCfg.tradeTypeList) do
    local cfg = PlayerData:GetFactoryData(trade.typeId, "ListFactory")
    for i, v in pairs(cfg.achievementList) do
      table.insert(achievements, v.id)
    end
  end
  for i, v in pairs(activityCfg.battleList) do
    table.insert(achievements, v.missionId)
  end
  totalNum = #achievements
  for i, id in pairs(achievements) do
    local state = PlayerData.GetQuestState(id)
    if state == EnumDefine.EQuestState.Finish or state == EnumDefine.EQuestState.Receive then
      finishNum = finishNum + 1
    end
  end
  return finishNum, totalNum
end

function DataModel.GetProfit(profitKey)
  if PlayerData:GetActivityAct(86000001) then
    local activityData = PlayerData.ServerData.all_activities.ing["86000001"]
    if activityData and activityData.goods then
      if profitKey == "addProfit" then
        if activityData.goods["82900046"] then
          return activityData.goods["82900046"].add_pf or 0
        end
      elseif profitKey == "onceProfit" and activityData.goods["82900046"] then
        return activityData.goods["82900046"].once_pf or 0
      end
    end
  end
  return 0
end

return DataModel
