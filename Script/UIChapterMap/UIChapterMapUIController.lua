local View = require("UIChapterMap/UIChapterMapView")
local DataModel = require("UIChapterMap/UIChapterMapDataModel")
local model = {}
local CheckLevel = function(levelId)
  local table = {}
  if PlayerData:GetLevelPass(levelId) == true then
    table.cleared = true
    table.newLevel = false
    return table
  end
  table.cleared = false
  table.newLevel = LevelCheck.CheckPreLevel(levelId)
  return table
end
local SetLevelLabelRank = function(level)
  for i = 1, 3 do
    local name = "Img_Star_" .. i
    local star = level.Group_Normal.Group_Label.Group_StarEmit[name]
    if star ~= nil then
      star:SetActive(i <= level.data.star)
    end
  end
end

function model.RefreshLevel(level, clear, showSub, newLevel)
  if showSub ~= true then
    level.self:SetActive(false)
    return
  end
  level.self:SetActive(true)
  level.Btn_Item:SetActive(clear or newLevel)
  level.Group_Normal.Img_PointUnclear:SetActive(not clear)
  level.Group_Normal.Img_PointCleared:SetActive(clear)
  level.Group_Normal.Img_MarkCleared:SetActive(clear and not newLevel)
  level.Group_Normal.Img_MarkUnclear:SetActive(newLevel)
  level.Group_Normal.Group_Label:SetActive(clear)
  if newLevel == true then
    level.Group_Normal.Img_MarkUnclear.Txt_LevelSid:SetText(level.data.idxDes)
    level.Group_Normal.Img_MarkUnclear.Txt_ChapterIndex:SetText(level.data.chapterIdxDes)
  else
    level.Group_Normal.Img_MarkCleared.Txt_LevelSid:SetText(level.data.idxDes)
    level.Group_Normal.Img_MarkCleared.Txt_ChapterIndex:SetText(level.data.chapterIdxDes)
  end
  if clear == true then
    SetLevelLabelRank(level)
  end
end

local RefreshNode = function(node, cleared, showSub, levelChain)
  if showSub ~= true then
    node.self:SetActive(false)
    return
  end
  node.self:SetActive(true)
  node.Img_Active:SetActive(cleared)
  node.Img_Inactive:SetActive(not cleared)
  node.Img_Decoration:SetActive(levelChain == true)
end
local RefreshLCNode = function(node, cleared)
  node.Img_Active:SetActive(cleared)
  node.Img_Inactive:SetActive(not cleared)
end

function model.RefreshLevelEffect(ca)
  local effectMark = PlayerData:GetFactoryData(ca.spineMarkId, "EffectFactory")
  local effectPoint = PlayerData:GetFactoryData(ca.spinePointId, "EffectFactory")
  local levelEffect = View.Group_Map.Group_LevelEffect
  levelEffect.Spine_Mark:SetData(effectMark.resUrl, effectMark.aniName)
  levelEffect.Spine_Point:SetData(effectPoint.resUrl, effectPoint.aniName)
  levelEffect.Txt_ChapterIndex:SetText(DataModel.chapterAbbreviate)
end

function model.RefreshBackground(ca)
  View.Group_Map.Img_Background:SetSprite(ca.chapterMapBackground)
end

function model:RefreshTrackUI(node, cleared, showSub, tweenId)
  if node == nil then
    return
  end
  if node.data.type == "Group_Level" or node.data.type == "Group_LCLevel" then
    local result = CheckLevel(node.data.levelId)
    if result.cleared == true then
      DataModel.lastClearedLevel = node
    end
    self.RefreshLevel(node, result.cleared, showSub, result.newLevel)
    cleared = result.cleared
    if tweenId ~= nil and tweenId == node.data.levelId and PlayerData:GetLevelPass(node.data.levelId) == true then
      cleared = false
    end
  elseif node.data.type == "Group_Route" then
    RefreshNode(node, cleared, showSub)
  end
  if node.data.next == nil then
    return
  end
  for k, v in pairs(node.data.next) do
    local show = DataModel.subLevelList[v.data.name]
    if show == nil then
      show = showSub
    end
    self:RefreshTrackUI(v, cleared, show, tweenId)
  end
end

function model:DoTween(node, tweenTime)
  local callback = function()
    node.Img_Inactive:SetActive(false)
    for k, v in pairs(node.data.next) do
      self:DoTween(v, tweenTime)
    end
  end
  if next(node.data.next) == nil then
    return
  end
  if node.data.hasLevel == true then
    PlayerData:DeletePlayerPrefs(tostring(DataModel.chapterId))
    return
  end
  if node.data.type == "gray" then
    return
  end
  local fillOrigin = GetFillOrigin(node.data.rot, node.data.dir)
  node.Img_Active:SetActive(true)
  if node.data.a == "135" then
    View.Group_Map:DoTween(node.Img_Active.Img, fillOrigin, 0.9, tweenTime, callback)
  else
    View.Group_Map:DoTween(node.Img_Active.Img, fillOrigin, 1, tweenTime, callback)
  end
end

function model:RefreshLCLevelTrack(node)
  if node == nil then
    return
  end
  if node.data.type == "Group_LCLevel" then
    local levelIndex = 0
    if PlayerData.ServerData.level_chain.levelIndex ~= nil then
      levelIndex = PlayerData.ServerData.level_chain.levelIndex
    end
    node.Group_Normal.Img_MarkCleared.self:SetActive(node.data.idx == levelIndex + 1)
    node.Btn_Item:SetActive(node.data.idx == levelIndex + 1)
    node.Btn_Bonus:SetActive(levelIndex >= node.data.idx)
  else
    RefreshLCNode(node, false)
  end
  if node.data.next == nil then
    return
  end
  for k, v in pairs(node.data.next) do
    self:RefreshLCLevelTrack(v)
  end
end

return model
