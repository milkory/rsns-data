local module = {}
local cacheQuest = {}
local questCallBack = {}
local cachedCompleted = false
local InvokeQuestCallBack = function(id)
  for k, v in pairs(questCallBack) do
    v()
  end
end

function module.AcceptQuest(id)
  if cacheQuest[id] == nil then
    local questCA = PlayerData:GetFactoryData(id)
    local questServer = PlayerData.ServerData.quests
    if questCA.questType == "Main" then
      questServer = questServer.mq_quests[tostring(id)]
    elseif questCA.questType == "Side" then
      questServer = questServer.branch_quests[tostring(id)]
    end
    if questServer then
      local t = {}
      t.id = id
      t.endTime = -1
      cacheQuest[id] = t
    end
  end
end

function module.CancelQuest(id)
  cacheQuest[id] = nil
  InvokeQuestCallBack(id)
end

function module.CompleteQuest(id)
  cacheQuest[id] = nil
  InvokeQuestCallBack(id)
end

function module.UpdateCacheQuest(force)
  if not force and cachedCompleted then
    return
  end
  cachedCompleted = true
  cacheQuest = {}
  for k, v in pairs(PlayerData.ServerData.quests) do
    if k == "mq_quests" or k == "branch_quests" then
      for k1, v1 in pairs(v) do
        local id = tonumber(k1)
        local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
        if questCA == nil then
          error("任务id:" .. id .. "不存在本地配置表,请检查配置")
        end
        if v1.recv == 0 and v1.unlock == 1 then
          local t = {}
          t.id = id
          t.endTime = -1
          cacheQuest[id] = t
        end
      end
    end
  end
end

local detailDoCheck = function(selfInfo)
  if not module.CheckQuestTime(selfInfo.questId) then
    CommonTips.OpenTips(80602659)
    return false
  end
  return true
end
local ActionToDialog = function(selfInfo)
  if not detailDoCheck(selfInfo) then
    return false
  end
  UIManager:Open(UIPath.UIDialog, Json.encode({
    id = selfInfo.eventId
  }))
  return true
end
local ActionToLevel = function(selfInfo)
  if not detailDoCheck(selfInfo) then
    return false
  end
  local status = selfInfo.status
  if status == nil then
    status = {
      Current = "Chapter",
      squadIndex = PlayerData.BattleInfo.squadIndex,
      hasOpenThreeView = false
    }
  end
  PlayerData.Last_Chapter_Parms = {}
  PlayerData.BattleInfo.battleStageId = selfInfo.eventId
  PlayerData.BattleCallBackPage = selfInfo.url
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
  return true
end

function module.CheckEventOpen(id, params)
  id = tonumber(id)
  if not cachedCompleted then
    module.UpdateCacheQuest()
  end
  if 0 < id then
    local ca = PlayerData:GetFactoryData(id)
    if ca == nil then
      return {}
    end
    local returnTable = {}
    local addToReturn = function(addInfo, addTable, param)
      local t = {}
      for k, v in pairs(addInfo) do
        t[k] = v
      end
      if param ~= nil then
        for k, v in pairs(param) do
          t[k] = v
        end
      end
      if addInfo.eventType == "Dialog" then
        t.action = ActionToDialog
      elseif addInfo.eventType == "Level" then
        t.action = ActionToLevel
      end
      table.insert(addTable, t)
    end
    for i, v in ipairs(ca.eventList) do
      if cacheQuest[v.questId] and module.CheckQuestTime(v.questId) and module.CheckQuestPreQuestComplete(v.questId) then
        addToReturn(v, returnTable, params)
      end
    end
    return returnTable
  end
  return {}
end

function module.CheckQuestTime(questId)
  if 0 < questId then
    local questCA = PlayerData:GetFactoryData(questId)
    if questCA == nil then
      return false
    end
    return module.CheckTime(questCA.activityId, questCA.startTime, questCA.endTime)
  end
  return false
end

function module.CheckQuestPreQuestComplete(questId)
  if 0 < questId then
    local questCA = PlayerData:GetFactoryData(questId)
    if questCA == nil then
      return false
    end
    if (questCA.questType == "Main" or questCA.questType == "Side") and questCA.preQuestId and 0 < questCA.preQuestId then
      local strPreId = tostring(questCA.preQuestId)
      local mainQuest = PlayerData.ServerData.quests.mq_quests
      local preQuestInfo = mainQuest[strPreId]
      if preQuestInfo == nil then
        local branchQuest = PlayerData.ServerData.quests.branch_quests
        preQuestInfo = branchQuest[strPreId]
      end
      if preQuestInfo == nil or 0 >= preQuestInfo.recv then
        return false
      end
    end
    return true
  end
  return false
end

function module.GetQuestEndTime(questId)
  if 0 < questId then
    local questCA = PlayerData:GetFactoryData(questId)
    local endTimeStr = ""
    if questCA.activityId and 0 < questCA.activityId then
      local activityCA = PlayerData:GetFactoryData(questCA.activityId)
      if activityCA.isTime then
        endTimeStr = activityCA.endTime
      end
    else
      endTimeStr = questCA.endTime
    end
    if endTimeStr ~= "" then
      return TimeUtil:TimeStamp(endTimeStr)
    end
  end
  return -1
end

function module.CheckTime(activityId, startTime, endTime)
  local innerCheckTime = function(innerStartTime, innerEndTime)
    local curTime = TimeUtil:GetServerTimeStamp()
    if innerStartTime ~= nil and innerStartTime ~= "" then
      local startTimeStamp = TimeUtil:TimeStamp(innerStartTime)
      if curTime < startTimeStamp then
        return false
      end
    end
    if innerEndTime == nil or innerEndTime == "" then
      return true
    else
      local endTimeStamp = TimeUtil:TimeStamp(innerEndTime)
      return curTime <= endTimeStamp
    end
  end
  if activityId and 0 < activityId then
    local activityCA = PlayerData:GetFactoryData(activityId)
    if activityCA.isTime then
      local res = innerCheckTime(activityCA.startTime, activityCA.endTime)
      if res then
        return res
      end
    end
  elseif startTime ~= "" or endTime ~= "" then
    local res = innerCheckTime(startTime, endTime)
    if res then
      return res
    end
  else
    return true
  end
  return false
end

function module.CheckTalkDo(eventList, parentView, buildingId, returnDo)
  local count = #eventList
  if 0 < count then
    if count == 1 then
      if not eventList[1]:action() then
        eventList[1] = nil
      end
    elseif parentView ~= nil then
      UIManager:Open(UIPath.TalkPlus, nil, returnDo)
      local childController = require("UITalkPlus/UITalkPlusController")
      childController:BindParentInfo(parentView, eventList, buildingId)
    end
    return true
  end
  return false
end

function module.CheckQuestShow(id)
  local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
  if questCA.parentQuest and questCA.parentQuest > 0 then
    return false
  end
  if not QuestProcess.CheckQuestTime(id) then
    return false
  end
  if not QuestProcess.CheckQuestPreQuestComplete(id) then
    return false
  end
  return true
end

function module.Clear()
  cacheQuest = {}
  questCallBack = {}
  cachedCompleted = false
end

function module.AddQuestCallBack(key, callBack)
  questCallBack[key] = callBack
end

function module.RemoveQuestCallBack(key)
  questCallBack[key] = nil
end

return module
