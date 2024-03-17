local UIController = require("UIChapterMap/UIChapterMapUIController")
local DataModel = require("UIChapterMap/UIChapterMapDataModel")
local View = require("UIChapterMap/UIChapterMapView")
local EventListener = require("UIChapterMap/UIChapterMapEventListener")
local ViewChapter = require("UIChapter/UIChapterView")
model = {}
local SetLevelStar = function(level)
  local factoryData = PlayerData:GetFactoryData(level.data.levelId, "LevelFactory")
  local levelData = PlayerData.ServerData.chapter_level[tostring(level.data.levelId)]
  local star = 0
  if levelData ~= nil then
    star = PlayerData:Score2Rank(factoryData.maxScoreList, levelData.score).num
  end
  return star
end
local Split = function(str, sep)
  if sep == nil then
    return {}
  end
  local fields = {}
  local pattern = string.format("[^%s]+", sep)
  str:gsub(pattern, function(res)
    fields[#fields + 1] = res
  end)
  return fields
end

function model.GenSubLevelList(ca)
  local table = {}
  for k, v in pairs(ca.subLevelList) do
    local showSub = PlayerData:GetLevelPass(v.mainLevelId)
    if table[v.nodeName] == nil then
      table[v.nodeName] = showSub
    end
  end
  return table
end

function model:GenTrackTable(group_Track, lineName, parentName)
  local track = {}
  for k, v in pairs(group_Track) do
    if k ~= "self" then
      local num = Split(k, "Group_%a+")[1]
      local type = string.sub(k, 1, string.len(k) - string.len(num))
      type = type:gsub("^%l", string.upper)
      type = type:gsub("_%l", string.upper)
      if type == "Group_Line" then
        track[num] = self:GenTrackTable(v, k)
      else
        if v.data ~= nil then
          v.data.next = nil
        end
        v.data = {}
        if lineName ~= nil then
          v.data.name = lineName .. "/" .. k
        else
          v.data.name = k
        end
        v.data.type = type
        if parentName ~= nil and type == "Group_LCLevel" then
          v.data.parentName = parentName
        end
        track[num] = v
      end
    end
  end
  return track
end

function model:ContactNodes(trackTable, prevNodes, levelNodeList)
  local node
  local totalCount = table.count(trackTable)
  local i = 1
  while totalCount >= i do
    node = trackTable[tostring(i)]
    if node.data == nil or node.data.type == nil then
      do
        local crossNodeTable = {}
        while node ~= nil and (node.data == nil or node.data.type == nil) do
          local tempNodes = {
            prevNodes[1]
          }
          table.insert(crossNodeTable, self:ContactNodes(node, tempNodes, levelNodeList))
          i = i + 1
          node = trackTable[tostring(i)]
        end
        prevNodes = crossNodeTable
      end
    else
      if node.data.type == "Group_Level" or node.data.type == "Group_LCLevel" then
        table.insert(levelNodeList, node)
      end
      if prevNodes ~= nil then
        for k, prevNode in pairs(prevNodes) do
          if prevNode.data.next == nil then
            prevNode.data.next = {}
          end
          table.insert(prevNode.data.next, node)
        end
      end
      prevNodes = {}
      table.insert(prevNodes, node)
      i = i + 1
    end
  end
  return node
end

function model.ConcatLevel(levelList, caLevelList, list2)
  for i = 1, table.count(levelList) do
    local level = levelList[i]
    if caLevelList[i] == nil then
      print_r("关卡数量不一致或关卡配置为空！！！")
    end
    local levelId = caLevelList[i].levelId
    level.data.levelId = levelId
    level.data.idx = caLevelList[i].index
    if level.data.idx == nil or level.data.idx == "" then
      level.data.idx = i
    end
    level.data.sid = i
    level.data.idxDes = caLevelList[i].indexDes
    level.data.chapterIdxDes = caLevelList[i].chapterIndexDes
    level.data.isSpecialLevel = caLevelList[i].isSpecialLevel
    list2[levelId] = level
    level.data.star = SetLevelStar(level)
    levelList[i].Btn_Item:SetClickParam(levelId)
  end
end

function model.ConcatLCLevel(levelList, caLevelList, list2)
  for i = 1, table.count(levelList) do
    local level = levelList[i]
    local levelId = caLevelList[i].levelId
    level.data.levelId = levelId
    level.data.idx = i
    table.insert(list2, level)
    levelList[i].Btn_Item:SetClickParam(i)
    levelList[i].Btn_Bonus:SetClickParam(i)
  end
end

function model:DoTween(start, time)
  local node = start
  local callback = function()
    if node.data.next == nil then
      return
    end
    if node.data.type == "Group_Route" then
      node.Img_Inactive:SetActive(false)
    end
    for k, v in pairs(node.data.next) do
      self:DoTween(v, time)
    end
  end
  local fillOrigin = 0
  if node.data.type == "Group_Route" then
    node.Img_Active:SetActive(true)
    View.Group_Map:DoTween(node.Img_Active.Img, fillOrigin, 1, time, callback)
  else
  end
end

function model:LevelChainRefresTrackhUI(node)
  if node.data.type == "Group_Route" then
    node.Img_Decoration:SetActive(true)
  else
    UIController.RefreshLevel(node, false, false)
  end
  if node.data.next == nil then
    return
  end
  for k, v in pairs(node.data.next) do
    self:LevelChainRefresTrackhUI(v)
  end
end

function ResetLevelChainUI(node, isStart)
  local start = isStart
  if node.data.type == "Group_LCLevel" then
    RefreshLevel(node, start)
  else
    RefreshRouteUI(node, start)
  end
  if node.data.isStart == true then
    start = false
  end
  if node.data.next ~= nil then
    for k, v in pairs(node.data.next) do
      ResetLevelChainUI(v, start)
    end
  end
end

function model.UnlockLevelChain(levelChain)
  for k, v in pairs(View.Group_Map.Group_LevelChain) do
    if k ~= "self" and k ~= "Img_LCBack" then
      v.Group_Lock.self:SetActive(true)
      v.Group_Unlock.self:SetActive(false)
    end
  end
  levelChain.Group_Lock.self:SetActive(false)
  levelChain.Group_Unlock.self:SetActive(true)
  ResetLevelChainUI(levelChain.Group_Unlock.Group_Route1, true)
end

function model:LevelChainDoTween(node, time)
  local callback = function()
    if node.data.next == nil then
      EventListener.isTweening = false
      View.Group_Map.Group_LevelChain.self:SetActive(true)
      return
    end
    for k, v in pairs(node.data.next) do
      self:LevelChainDoTween(v, time)
    end
  end
  EventListener.isTweening = true
  if node.data.type == "Group_Route" then
    node.Img_Decoration:SetActive(true)
    node.Img_Decoration.Img.fillOrigin = 0
    View.Group_Map:DoTween2(node.Img_Decoration.Img, 1, time, callback)
  else
    UIController.RefreshLevel(node, false, false)
    callback()
  end
end

function model:LevelChainDoTween2(node, time)
  local callback = function()
    if node.data.next == nil then
      return
    end
    for k, v in pairs(node.data.next) do
      self:LevelChainDoTween2(v, time)
    end
  end
  if node.data.type == "Group_Route" then
    node.Img_Decoration:SetActive(true)
    node.Img_Decoration.Img.fillOrigin = 1
    View.Group_Map:DoTween2(node.Img_Decoration.Img, 0, time, callback)
  else
    DataModel.lastClearedLevel = node
    UIController.RefreshLevel(node, true, false)
    callback()
  end
end

function checkLevelChain()
  for k, v in pairs(View.Group_Map.Group_LevelChain) do
    if k ~= "self" then
      return true
    end
  end
  return false
end

function model:LevelChainReverseTracks()
  local TrackUIRestoration = function()
    PlayerData:DeletePlayerPrefs("LevelChain" .. DataModel.chapterId)
    DataModel.levelChainUnlocked = false
    View.Group_Map.Group_LevelChain.self:SetActive(false)
    self:LevelChainDoTween2(View.Group_Map.Group_Track.Group_Route1, 0.2)
    EventListener:EnableListener()
  end
  if DataModel.levelChainUnlocked == true then
    if checkLevelChain() == true then
      EventListener:DisableListener()
      CommonTips.OnPrompt(80600207, nil, nil, function()
        ViewChapter.Btn_OpenLevelChain.self:SetActive(false)
        TrackUIRestoration()
      end, function()
        EventListener:EnableListener()
      end)
    else
      TrackUIRestoration()
    end
  else
    ViewChapter.Btn_OpenLevelChain.self:SetActive(false)
    self:LevelChainDoTween(View.Group_Map.Group_Track.Group_Route1, 0.1)
    DataModel.levelChainUnlocked = true
    PlayerData:SetPlayerPrefs("int", "LevelChain" .. DataModel.chapterId, 1)
  end
end

return model
