local DataModel = {}
DataModel.allStage = {}
DataModel.curStageIndex = 0
DataModel.curStageCfg = {}
DataModel.curNum = 0
DataModel.finalTargetNum = 100

function DataModel.InitData()
  DataModel.allStage = {}
  DataModel.curStageIndex = 0
  DataModel.curStageCfg = {}
  DataModel.curNum = 0
  DataModel.finalTargetNum = 100
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local allStage = activityCfg.ServerProgressList or {}
  for i, v in ipairs(allStage) do
    table.insert(DataModel.allStage, v)
  end
  local id = allStage[#allStage] and allStage[#allStage].id
  if id then
    local finalQuestCfg = PlayerData:GetFactoryData(id, "QuestFactory")
    DataModel.finalTargetNum = finalQuestCfg.num
  end
  local notReceiveStage = {}
  local receiveStage = {}
  local sortAllStage = {}
  for i, v in ipairs(DataModel.allStage) do
    if PlayerData.GetQuestState(v.id) == EnumDefine.EQuestState.Receive then
      table.insert(receiveStage, v)
    else
      table.insert(notReceiveStage, v)
    end
  end
  for i, v in ipairs(notReceiveStage) do
    table.insert(sortAllStage, v)
  end
  for i, v in ipairs(receiveStage) do
    table.insert(sortAllStage, v)
  end
  DataModel.allStage = sortAllStage
  DataModel.curNum = DataModel.GetCurNum()
  local info = DataModel.GetCurStageInfo()
  DataModel.curStageIndex = info.index
  DataModel.curStageCfg = info.cfg
end

function DataModel.GetCurStageInfo()
  local curNum = DataModel.GetCurNum()
  return DataModel.GetStageInfo(curNum)
end

function DataModel.GetNextStageInfo()
  local info = {
    index = 0,
    cfg = {}
  }
  local curNum = DataModel.GetCurNum()
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local allStage = activityCfg.ServerProgressList or {}
  for i, v in ipairs(allStage) do
    local questCfg = PlayerData:GetFactoryData(v.id, "QuestFactory")
    if curNum < questCfg.num then
      info.cfg = v
      info.index = i
      break
    end
    if i == #allStage then
      info.cfg = v
      info.index = i
    end
  end
  if info.index == 1 and 0 >= info.cfg.buff then
    info.index = 0
  end
  return info
end

function DataModel.GetStageInfo(num)
  local info = {
    index = 0,
    cfg = {}
  }
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local allStage = activityCfg.ServerProgressList or {}
  for i, v in ipairs(allStage) do
    local questCfg = PlayerData:GetFactoryData(v.id, "QuestFactory")
    if num >= questCfg.num then
      info.cfg = v
      info.index = i
    else
      if i == 1 then
        info.cfg = v
        info.index = i
      end
      break
    end
  end
  if info.index == 1 and 0 >= info.cfg.buff then
    info.index = 0
  end
  return info
end

function DataModel.GetCurNum()
  local curNum = 0
  local serverQuests = PlayerData.ServerData.server_quests or {}
  for i, v in pairs(serverQuests) do
    curNum = math.max(curNum, v.pcnt)
  end
  return curNum
end

function DataModel.GetRedPointState()
  local activityCfg = PlayerData:GetFactoryData(86000001, "ActivityFactory")
  local allStage = activityCfg.ServerProgressList or {}
  for i, v in ipairs(allStage) do
    local state = PlayerData.GetQuestState(v.id)
    if state == EnumDefine.EQuestState.Finish then
      return true
    end
  end
  return false
end

return DataModel
