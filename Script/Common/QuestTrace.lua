local module = {}
local listener = {}

function module.CheckQuestEnd()
  local questTraceInfo = PlayerData:GetQuestTrace()
  if questTraceInfo[1] ~= nil then
    local info = questTraceInfo[1]
    local curTime = TimeUtil:GetServerTimeStamp()
    if info.endTime ~= -1 and curTime >= info.endTime or not QuestProcess.CheckQuestTime(info.id) then
      PlayerData:RemoveQuestTrace()
      return nil
    end
    local questCA = PlayerData:GetFactoryData(info.id, "QuestFactory")
    if questCA and questCA.questType == "Home" then
      local stations = PlayerData:GetHomeInfo().stations
      if stations ~= nil then
        local quests = stations[tostring(questCA.startStation)].quests
        if quests ~= nil then
          for k, v in pairs(quests) do
            for k1, v1 in pairs(v) do
              if tonumber(k1) == info.id and v1.time ~= -1 then
                return info.id
              end
            end
          end
        end
      end
      PlayerData:RemoveQuestTrace()
      return nil
    else
      local quests = PlayerData.ServerData.quests
      for k, v in pairs(quests) do
        if k == "mq_quests" or k == "branch_quests" then
          for k1, v1 in pairs(v) do
            if tonumber(k1) == info.id and v1.recv == 0 then
              return info.id
            end
          end
        elseif k == "mark_order" then
          for k1, v1 in pairs(v) do
            for k2, v2 in pairs(v1) do
              if tonumber(v2) == info.id then
                return info.id
              end
            end
          end
        end
      end
    end
  end
  return nil
end

function module.SetQuestTrace(element)
  local questId = module.CheckQuestEnd()
  local isShow = questId ~= nil
  element.Btn_Navigation.Txt_Target:SetActive(isShow)
  if isShow then
    local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
    if questCA then
      if questCA.questType == "Home" then
        local stations = PlayerData:GetHomeInfo().stations
        local targetName = questCA.endStationList[1].id
        local sQuestId = tostring(questId)
        for k, v in pairs(stations) do
          local isFind = false
          local quests = v.quests
          if quests ~= nil then
            for k1, v1 in pairs(quests) do
              if v1[sQuestId] ~= nil and v1[sQuestId].sid ~= nil then
                local stationCA = PlayerData:GetFactoryData(v1[sQuestId].sid, "HomeStationFactory")
                targetName = stationCA.name
                isFind = true
                break
              end
            end
          end
          if isFind then
            break
          end
        end
        local showText = ""
        if questCA.cocQuestType == "Buy" and questCA.isShowProgress then
          local serverData
          local stationInfo = PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)]
          if stationInfo ~= nil and stationInfo.quests.Buy ~= nil and stationInfo.quests.Buy[tostring(questCA.id)] ~= nil then
            serverData = stationInfo.quests.Buy[tostring(questCA.id)].info
          end
          local curNum = 0
          if serverData ~= nil then
            curNum = serverData[tostring(questCA.goodsList[1].id)] or 0
          end
          local maxNum = questCA.goodsList[1].num
          showText = string.format(GetText(80600776), curNum, maxNum)
        end
        element.Btn_Navigation.Txt_Target:SetText(string.format(questCA.describe, targetName) .. showText)
      else
        local showText = ""
        if questCA.isShowProgress then
          local curNum = 0
          local serverKey = ""
          if questCA.questType == "Main" then
            serverKey = "mq_quests"
          elseif questCA.questType == "Side" then
            serverKey = "branch_quests"
          end
          if serverKey ~= "" then
            local serverData = PlayerData.ServerData.quests[serverKey]
            if serverData and serverData[tostring(questCA.id)] then
              curNum = serverData[tostring(questCA.id)].pcnt or 0
            end
          end
          showText = string.format(GetText(80600776), curNum, questCA.num)
        end
        element.Btn_Navigation.Txt_Target:SetText(questCA.describe .. showText)
      end
    end
  end
  element.Btn_Quest.Img_New:SetActive(0 < RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.Quest))
end

function module.AcceptQuest(questId)
  QuestProcess.AcceptQuest(questId)
  local questTraceInfo = PlayerData:GetQuestTrace()
  if questTraceInfo == nil or #questTraceInfo == 0 then
    PlayerData:DeletePlayerPrefs("QuestRed" .. questId)
    module.AddRedNodeData(questId)
    local t = {}
    t.id = questId
    local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
    if questCA.parentQuest and 0 < questCA.parentQuest then
      return
    end
    if questCA.questType == "Main" or questCA.questType == "Side" or questCA.questType == "Home" then
      if questCA.questType == "Home" and 0 < questCA.timeLimit then
        t.endTime = TimeUtil:GetServerTimeStamp() + questCA.timeLimit * 3600
      else
        t.endTime = -1
      end
      if questCA.questType == "Home" then
        local stations = PlayerData:GetHomeInfo().stations
        if stations ~= nil then
          local quests = stations[tostring(questCA.startStation)].quests
          if quests ~= nil then
            for k, v in pairs(quests) do
              local strQuestId = tostring(questId)
              if v[strQuestId] and v[strQuestId].sid then
                t.endStation = tonumber(v[strQuestId].sid)
                break
              end
            end
          end
        end
      end
      PlayerData:SetQuestTrace({
        [1] = t
      })
    end
  elseif questTraceInfo[1].id ~= questId then
    PlayerData:DeletePlayerPrefs("QuestRed" .. questId)
    module.AddRedNodeData(questId)
  end
end

function module.CancelQuest(questId)
  QuestProcess.CancelQuest(questId)
  questId = tonumber(questId)
  local questTraceInfo = PlayerData:GetQuestTrace()
  if questTraceInfo[1] ~= nil then
    local info = questTraceInfo[1]
    if info.id == questId then
      PlayerData:RemoveQuestTrace()
    end
  end
  PlayerData:DeletePlayerPrefs("QuestRed" .. questId)
  module.DeleteRedNodeData(questId)
end

local findMainQuest = function()
  local quests = PlayerData.ServerData.quests.mq_quests
  for k, v in pairs(quests) do
    local id = tonumber(k)
    if v.recv == 0 and v.unlock == 1 and QuestProcess.CheckQuestTime(id) and QuestProcess.CheckQuestPreQuestComplete(id) then
      local t = {}
      t.id = id
      t.endTime = -1
      return t
    end
  end
  return nil
end
local findSideQuest = function()
  local quests = PlayerData.ServerData.quests.branch_quests
  for k, v in pairs(quests) do
    local id = tonumber(k)
    if v.recv == 0 and v.unlock == 1 and QuestProcess.CheckQuestTime(id) and QuestProcess.CheckQuestPreQuestComplete(id) then
      local t = {}
      t.id = id
      t.endTime = -1
      return t
    end
  end
  return nil
end
local findHomeQuest = function(stationId)
  local findQuest = function(quests)
    if quests ~= nil then
      for k, v in pairs(quests) do
        for k1, v1 in pairs(v) do
          if v1.time ~= -1 then
            local t = {}
            t.id = tonumber(k1)
            local questCA = PlayerData:GetFactoryData(t.id, "QuestFactory")
            if questCA.timeLimit ~= nil and questCA.timeLimit ~= -1 then
              t.endTime = v1.time + questCA.timeLimit * 3600
            else
              t.endTime = -1
            end
            t.endStation = v1.sid and tonumber(v1.sid) or questCA.endStationList[1].id
            return t
          end
        end
      end
    end
    return nil
  end
  local stations = PlayerData:GetHomeInfo().stations
  if stationId == nil then
    local station_info = PlayerData:GetHomeInfo().station_info
    if station_info ~= nil then
      local stop_info = station_info.stop_info
      if stop_info ~= nil and stop_info[2] == -1 then
        local curStayId = tonumber(stop_info[1])
        stationId = curStayId
      end
    end
  end
  local t
  if stationId ~= nil then
    local quests = stations[tostring(stationId)].quests
    t = findQuest(quests)
    if t ~= nil then
      return t
    end
  end
  for sId, sValue in pairs(stations) do
    if tonumber(sId) ~= stationId then
      local quests = sValue.quests
      t = findQuest(quests)
      if t ~= nil then
        return t
      end
    end
  end
  return t
end
local AutoSetQuestTrace = function(questId)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if questCA.nextQuest ~= nil and #questCA.nextQuest > 0 then
    local t = {}
    t.id = questCA.nextQuest[1].id
    t.endTime = -1
    return t
  else
    local t
    local findFunc = {}
    if questCA.questType == "Main" then
      t = findMainQuest()
      if t ~= nil then
        return t
      end
      findFunc[1] = findSideQuest
      findFunc[2] = findHomeQuest
    elseif questCA.questType == "Side" then
      t = findSideQuest()
      if t ~= nil then
        return t
      end
      findFunc[1] = findMainQuest
      findFunc[2] = findHomeQuest
    elseif questCA.questType == "Home" then
      t = findHomeQuest(questCA.startStation)
      if t ~= nil then
        return t
      end
      findFunc[1] = findMainQuest
      findFunc[2] = findSideQuest
    end
    for k, v in pairs(findFunc) do
      t = v()
      if t ~= nil then
        return t
      end
    end
  end
  return nil
end
local IsChildQuest = function(parentQuestId, childQuestId)
  local questCA = PlayerData:GetFactoryData(childQuestId, "QuestFactory")
  if questCA and questCA.parentQuest == parentQuestId then
    return true
  end
  return false
end

function module.CompleteQuestOne(questId)
  questId = tonumber(questId)
  QuestProcess.CompleteQuest(questId)
  local questTraceInfo = PlayerData:GetQuestTrace()
  if questTraceInfo[1] ~= nil then
    local info = questTraceInfo[1]
    if info.id == questId then
      local t = AutoSetQuestTrace(questId)
      ListenerManager.Broadcast(ListenerManager.Enum.CompleteQuestInQuestTrace, questId)
      if t ~= nil then
        PlayerData:SetQuestTrace({
          [1] = t
        })
      else
        PlayerData:RemoveQuestTrace()
      end
    elseif IsChildQuest(info.id, questId) then
      ListenerManager.Broadcast(ListenerManager.Enum.CompleteQuestInQuestTrace, questId)
    end
    SdkReporter.TrackTaskComplete({taskId = questId})
  end
  ListenerManager.Broadcast(ListenerManager.Enum.CompleteQuest, {questId})
end

function module.CompleteQuest(questIds)
  local questTraceInfo = PlayerData:GetQuestTrace()
  if questTraceInfo[1] ~= nil then
    local info = questTraceInfo[1]
    for k, v in pairs(questIds) do
      local questId = tonumber(v)
      QuestProcess.CompleteQuest(questId)
      if info.id == questId then
        local t = AutoSetQuestTrace(questId)
        ListenerManager.Broadcast(ListenerManager.Enum.CompleteQuestInQuestTrace, questId)
        if t ~= nil then
          PlayerData:SetQuestTrace({
            [1] = t
          })
        else
          PlayerData:RemoveQuestTrace()
        end
      elseif IsChildQuest(info.id, questId) then
        ListenerManager.Broadcast(ListenerManager.Enum.CompleteQuestInQuestTrace, questId)
      end
      SdkReporter.TrackTaskComplete({taskId = questId})
    end
  end
  ListenerManager.Broadcast(ListenerManager.Enum.CompleteQuest, questIds)
end

local GetViewNode = function(url, nodePathStr)
  if not UIManager:IsPanelOpened(url) then
    return nil
  end
  local index = string.lastIndexOf(url, "/")
  local viewPath = string.sub(url, index + 1)
  local View = require("UI" .. viewPath .. "/UI" .. viewPath .. "View")
  local node
  if View then
    local nodePath = {}
    local pattern = "[^" .. "%." .. "]+"
    for str in string.gmatch(nodePathStr, pattern) do
      table.insert(nodePath, str)
    end
    node = View
    local nextNum = false
    for k2, v2 in pairs(nodePath) do
      local next
      if nextNum then
        nextNum = false
        local num = tonumber(string.sub(v2, #v2 - 1))
        next = node[num + 1]
      else
        next = node[v2]
      end
      if next then
        node = next
      elseif (v2 == "grid" or v2 == "Grid") and node.grid then
        node = node.grid
        nextNum = true
      end
    end
  end
  return node
end
local GetQuestStartStation = function(questId)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  return questCA.startStation or -1
end
local GetQuestEndStation = function(questId)
  local quest = PlayerData:GetQuestTrace()
  for k, v in pairs(quest) do
    if questId == v.id and v.endStation and tonumber(v.endStation) > 0 then
      return v.endStation
    end
  end
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if questCA.endStationList and #questCA.endStationList == 1 then
    return questCA.endStationList[1].id
  end
  if questCA.questType == "Home" then
    local stations = PlayerData:GetHomeInfo().stations
    if stations ~= nil then
      local quests = stations[tostring(questCA.startStation)].quests
      if quests ~= nil then
        for k, v in pairs(quests) do
          local strQuestId = tostring(questId)
          if v[strQuestId] and v[strQuestId].sid then
            return tonumber(v[strQuestId].sid)
          end
        end
      end
    end
  end
  return -1
end
local IsInStation = function(url, questId, intVal, stringVal, factoryVal)
  local station_info = PlayerData:GetHomeInfo().station_info
  if station_info ~= nil then
    local stop_info = station_info.stop_info
    if stop_info ~= nil and stop_info[2] == -1 then
      local curStayId = tonumber(stop_info[1])
      if curStayId == factoryVal then
        return true
      end
    end
  end
  return false
end
local IsActivated = function(url, questId, intVal, stringVal, factoryVal)
  local node = GetViewNode(url, stringVal)
  if node then
    if node.self then
      node = node.self
    end
    return node.IsActive
  end
end
local IsArrived = function(url, questId, intVal, stringVal, factoryVal)
  local isArrived = PlayerData:GetHomeInfo().station_info.is_arrived == 1
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  if 0 < factoryVal then
    return isArrived and factoryVal == TradeDataModel.EndCity
  end
  return isArrived
end
local IsEnoughGoods = function(url, questId, intVal, stringVal, factoryVal)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  local isEnough = false
  local serverQuestInfo = PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)].quests.Buy[tostring(questId)]
  if serverQuestInfo then
    isEnough = true
    for k, v in pairs(questCA.goodsList) do
      local curNum = PlayerData:GetGoodsById(v.id).num
      local needNum = v.num
      local curPcnt = serverQuestInfo.info[tostring(v.id)] or 0
      isEnough = isEnough and curNum >= needNum - curPcnt
    end
  end
  return isEnough
end
local IsInStartStation = function(url, questId, intVal, stringVal, factoryVal)
  local startStationId = GetQuestStartStation(questId)
  if 0 < startStationId then
    return IsInStation(url, questId, intVal, stringVal, startStationId)
  end
  return false
end
local IsInEndStation = function(url, questId, intVal, stringVal, factoryVal)
  local endStationId = GetQuestEndStation(questId)
  if 0 < endStationId then
    return IsInStation(url, questId, intVal, stringVal, endStationId)
  end
  return false
end
local IsArrivedStartStation = function(url, questId, intVal, stringVal, factoryVal)
  local startStationId = GetQuestStartStation(questId)
  if 0 < startStationId then
    return IsArrived(url, questId, intVal, stringVal, startStationId)
  end
  return false
end
local IsArrivedEndStation = function(url, questId, intVal, stringVal, factoryVal)
  local endStationId = GetQuestEndStation(questId)
  if 0 < endStationId then
    return IsArrived(url, questId, intVal, stringVal, endStationId)
  end
  return false
end
local keyFuncList = {
  IsInStation = IsInStation,
  IsActivated = IsActivated,
  IsArrived = IsArrived,
  IsEnoughGoods = IsEnoughGoods,
  IsInStartStation = IsInStartStation,
  IsInEndStation = IsInEndStation,
  IsArrivedStartStation = IsArrivedStartStation,
  IsArrivedEndStation = IsArrivedEndStation
}
local cacheQuestIdsInfo = {}
local curQuestTrace = {}
local cacheCurUrl = ""

local function DynamicShowRedNode(quest, url, setExtraBtnClick, parentQuestId)
  if parentQuestId == nil then
    parentQuestId = 0
  end
  for k1, v1 in pairs(cacheQuestIdsInfo) do
    local redNode = v1.redNode
    if v1.isShow and redNode and not redNode:IsNull() then
      redNode:HideDynamicGameObject()
      v1.isShow = false
    end
  end
  local cacheRedNodePath = {}
  for k, v in pairs(quest) do
    local questCA = PlayerData:GetFactoryData(k)
    if questCA.childQuestList and 0 < #questCA.childQuestList then
      local t = {}
      for k1, v1 in pairs(questCA.childQuestList) do
        if not PlayerData.IsQuestComplete(v1.id) then
          t[v1.id] = 0
        end
      end
      DynamicShowRedNode(t, url, true, k)
    else
      local traceId = 0
      local btnListId = 0
      local apiListId = 0
      for k1, v1 in pairs(questCA.traceList) do
        if v1.uiPath == url then
          traceId = v1.traceId
          btnListId = v1.btnListId
          apiListId = v1.apiListId
          if cacheQuestIdsInfo[k] == nil then
            cacheQuestIdsInfo[k] = {}
          end
          cacheQuestIdsInfo[k].url = v1.uiPath
          cacheQuestIdsInfo[k].parentQuestId = parentQuestId
          print_r("任务追踪Log..." .. "任务Id : " .. k .. "  追踪配置Id : " .. traceId)
          break
        end
      end
      if 0 < apiListId and cacheQuestIdsInfo[k].triggerProtocol == nil then
        local t = {}
        cacheQuestIdsInfo[k].triggerProtocol = t
        local listCA = PlayerData:GetFactoryData(apiListId, "ListFactory")
        for k1, v1 in pairs(listCA.apiList) do
          t[v1.api] = 0
        end
      end
      if setExtraBtnClick and 0 < btnListId then
        local listCA = PlayerData:GetFactoryData(btnListId, "ListFactory")
        local extraClickFunc = function()
          DynamicShowRedNode(curQuestTrace, url, false)
        end
        for k1, v1 in pairs(listCA.btnList) do
          local node = GetViewNode(url, v1.btnPath)
          if node and node.self then
            node = node.self
          end
          if node and node.SetExtraBtnClick then
            node:SetExtraBtnClick(extraClickFunc)
          end
        end
      end
      if 0 < traceId then
        local listCA = PlayerData:GetFactoryData(traceId, "ListFactory")
        local state = 0
        for k1, v1 in pairs(listCA.keyList) do
          local getResult = 0
          if keyFuncList[v1.key](url, k, v1.intVal, v1.stringVal, v1.factoryVal) then
            getResult = MathEx.pow(2, k1 - 1)
          end
          state = state + getResult
        end
        print_r("任务追踪Log..." .. "当前状态 : " .. state)
        for k1, v1 in pairs(listCA.stateList) do
          if v1.stateNo == state then
            local cache = cacheQuestIdsInfo[k]
            local nodePath = v1.nodePath
            if v1.tipsType == "StartStation" then
              local startStationId = GetQuestStartStation(k)
              local stationCA = PlayerData:GetFactoryData(startStationId, "HomeStationFactory")
              if stationCA then
                nodePath = stationCA.nodePath
              end
            elseif v1.tipsType == "EndStation" then
              local endStationId = GetQuestEndStation(k)
              local stationCA = PlayerData:GetFactoryData(endStationId, "HomeStationFactory")
              if stationCA then
                nodePath = stationCA.nodePath
              end
            end
            if nodePath ~= nil and nodePath ~= "" and cacheRedNodePath[nodePath] == nil then
              cacheRedNodePath[nodePath] = 0
              local node = GetViewNode(url, nodePath)
              if node then
                if node.self then
                  node = node.self
                end
                local prefab = v1.prefab
                if url == "UI/MainUI/MainUI" then
                  prefab = prefab .. "_Main"
                end
                node:SetDynamicGameObject(prefab, v1.offsetX, v1.offsetY)
                cache.redNode = node
                cache.isShow = true
                break
              end
            end
          end
        end
      end
    end
  end
end

local QuestTraceUIShow = function(url, setExtraBtnClick)
  if setExtraBtnClick == nil then
    setExtraBtnClick = true
  end
  DynamicShowRedNode(curQuestTrace, url, setExtraBtnClick)
end
local cacheUrlTipOrPop = {
  ["UI/HomeUpgrade/HomeBubble"] = true,
  ["UI/HomeUpgrade/HomeBubblePet"] = true,
  [UIPath.UIGuide] = true
}
local ToOpenPanelCallback = function(url)
  if cacheUrlTipOrPop[url] then
    return
  elseif cacheUrlTipOrPop[url] == nil and GuideManager:IsPanelTipOrPop(url) then
    cacheUrlTipOrPop[url] = true
    return
  end
  cacheCurUrl = url
  cacheUrlTipOrPop[url] = false
  QuestTraceUIShow(url, true)
end

function module.ProtocolCallback(protocolName)
  for k, v in pairs(cacheQuestIdsInfo) do
    if v.triggerProtocol and v.triggerProtocol[protocolName] and UIManager:IsPanelOpened(v.url) then
      QuestTraceUIShow(v.url)
      break
    end
  end
end

local isAddEvent = false
local CheckIsHomeQuest = function(questId)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if questCA and questCA.startStation > 0 then
    local quests = PlayerData:GetHomeInfo().stations[tostring(questCA.startStation)].quests
    if quests ~= nil then
      local questType = questCA.cocQuestType
      local questServerInfo = quests[questType]
      if questServerInfo and questServerInfo[tostring(questId)] then
        questServerInfo = questServerInfo[tostring(questId)]
        local endTime = 0
        if questCA.timeLimit ~= nil and 0 < questCA.timeLimit then
          endTime = questServerInfo.time + questCA.timeLimit * 3600
        end
        return endTime < TimeUtil:GetServerTimeStamp()
      end
    end
  end
  return false
end

function module.AddOpenPanelCallBack()
  if not isAddEvent then
    isAddEvent = true
    EventManager:AddOpenPanelEvent(ToOpenPanelCallback)
  end
  cacheQuestIdsInfo = {}
  curQuestTrace = {}
  local questTrace = PlayerData:GetQuestTrace()
  if questTrace[1] ~= nil then
    local info = questTrace[1]
    local curTime = TimeUtil:GetServerTimeStamp()
    if info.endTime ~= -1 and curTime >= info.endTime or not QuestProcess.CheckQuestTime(info.id) then
      PlayerData:RemoveQuestTrace()
      questTrace = {}
    end
  end
  for k, v in pairs(questTrace) do
    local isOk = PlayerData:IsHaveQuest(v.id, {
      "mq_quests",
      "branch_quests"
    })
    isOk = isOk or CheckIsHomeQuest(v.id)
    if isOk then
      curQuestTrace[v.id] = 0
    end
  end
  ListenerManager.AddListener(ListenerManager.Enum.SetQuestTrace, "QuestTraceUIShow", function(id)
    curQuestTrace[id] = 0
    if cacheCurUrl ~= "" then
      DynamicShowRedNode(curQuestTrace, cacheCurUrl, true)
    end
    PlayerData:SetPlayerPrefs("int", "QuestRed" .. id, 1)
    module.DeleteRedNodeData(id)
  end)
  ListenerManager.AddListener(ListenerManager.Enum.CompleteQuestInQuestTrace, "QuestTraceUIShow", function(id)
    curQuestTrace[id] = nil
    local func = function(param)
      if cacheQuestIdsInfo[param] then
        local redNode = cacheQuestIdsInfo[param].redNode
        if cacheQuestIdsInfo[param].isShow and not redNode:IsNull() then
          redNode:HideDynamicGameObject()
        end
      end
      cacheQuestIdsInfo[param] = nil
    end
    func(id)
    local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
    if questCA.childQuestList then
      for k, v in pairs(questCA.childQuestList) do
        func(v.id)
      end
    end
  end)
  ListenerManager.AddListener(ListenerManager.Enum.RemoveQuestTrace, "QuestTraceUIShow", function(id)
    curQuestTrace[id] = nil
    cacheQuestIdsInfo[id] = nil
    local questCA = PlayerData:GetFactoryData(id)
    if questCA and questCA.childQuestList then
      for k, v in pairs(questCA.childQuestList) do
        cacheQuestIdsInfo[v.id] = nil
      end
    end
  end)
  ListenerManager.AddListener(ListenerManager.Enum.CompleteQuest, "QuestTraceUIShow", function(ids)
    for i, questId in pairs(ids) do
      PlayerData:DeletePlayerPrefs("QuestRed" .. questId)
      module.DeleteRedNodeData(questId)
    end
  end)
  if table.count(curQuestTrace) == 0 then
    local findFunc = {}
    findFunc[1] = findMainQuest
    findFunc[2] = findSideQuest
    findFunc[3] = findHomeQuest
    for k, v in pairs(findFunc) do
      t = v()
      if t ~= nil then
        PlayerData:SetQuestTrace({
          [1] = t
        })
        break
      end
    end
  end
end

function module.RemoveOpenPanelCallBack()
  if isAddEvent then
    isAddEvent = false
    EventManager:RemoveOpenPanelEvent(ToOpenPanelCallback)
  end
end

function module.ClearQuestTraceInfo()
  module.RemoveOpenPanelCallBack()
  cacheQuestIdsInfo = {}
  curQuestTrace = {}
  cacheCurUrl = ""
end

function module.AddRedNodeData(questId)
  questId = tonumber(questId)
  if not QuestProcess.CheckQuestShow(questId) then
    return false
  end
  local questCA = PlayerData:GetFactoryData(questId)
  local redNodeName
  if questCA.questType == "Main" then
    redNodeName = RedpointTree.NodeNames.QuestMain
  elseif questCA.questType == "Side" then
    redNodeName = RedpointTree.NodeNames.QuestSide
  elseif questCA.questType == "Home" then
    redNodeName = RedpointTree.NodeNames.QuestHome
  elseif questCA.questType == "Order" then
    redNodeName = RedpointTree.NodeNames.QuestOrder
  end
  if redNodeName then
    local keyName = redNodeName .. "|" .. questId
    RedpointTree:InsertNode(keyName)
    RedpointTree:ChangeRedpointCnt(keyName, 1)
    return true
  end
  return false
end

function module.DeleteRedNodeData(questId)
  local redNodeName
  local questCA = PlayerData:GetFactoryData(questId)
  if questCA.questType == "Main" then
    redNodeName = RedpointTree.NodeNames.QuestMain
  elseif questCA.questType == "Side" then
    redNodeName = RedpointTree.NodeNames.QuestSide
  elseif questCA.questType == "Home" then
    redNodeName = RedpointTree.NodeNames.QuestHome
  elseif questCA.questType == "Order" then
    redNodeName = RedpointTree.NodeNames.QuestOrder
  end
  if redNodeName then
    local keyName = redNodeName .. "|" .. questId
    RedpointTree:ChangeRedpointCnt(keyName, -1)
    return RedpointTree:DeleteNode(keyName)
  end
  return false
end

return module
