local View = require("UIChapterMap/UIChapterMapView")
local ChapterMapUIController = require("UIChapterMap/UIChapterMapUIController")
local DataController = require("UIChapterMap/UIChapterMapDataController")
local DataModel = require("UIChapterMap/UIChapterMapDataModel")
local ChpaterNewDataController = require("UIChapterMap/UIChapterMapNewDataController")
local SquadDataController = require("UISquads/UISquadsDataController")
local UIChapterSettlement = require("UIChapter/UIChapterSettlement")

function ClearPlayerDataLevelChain()
  PlayerData.LevelChain = {}
  PlayerData.ServerData.level_chain.levelChainId = nil
  PlayerData.ServerData.level_chain.levelIndex = nil
  PlayerData.ServerData.level_chain.buffList = {}
  PlayerData.ServerData.level_chain.roles = {}
  PlayerData.ServerData.squad[100].role_list = {}
  PlayerData.ServerData.squad[100].header = nil
end

local _BattleStartCallback = function()
  PlayerData.BattleInfo.squadIndex = DataModel.curSquadIndex
  CBus:ChangeScene("Battle")
end

function GetBuff()
  Net:SendProto("level_chain.buff", function(json)
    local index = PlayerData.ServerData.level_chain.levelIndex
    if index == nil then
      return
    end
    local indexStr = tostring(index)
    local bufflist = PlayerData.ServerData.level_chain.buffList
    if bufflist == nil then
      bufflist = {}
    end
    if bufflist[indexStr] == nil then
      bufflist[indexStr] = {}
    end
    bufflist[indexStr].buffIdList = json.random_buff
    PlayerData.ServerData.level_chain.buffList = bufflist
  end)
end

local BattleFinishCallback = function(info)
  local res = Json.decode(info)
  PlayerData.BattleInfo.BattleResult = res
  CommonTips.OpenSettlement()
  local BattleResult = PlayerData.BattleInfo.BattleResult
  if BattleResult.isWin == true then
    PlayerData.ServerData.level_chain.levelIndex = PlayerData.ServerData.level_chain.levelIndex + 1
    if PlayerData.ServerData.level_chain.levelIndex ~= table.count(DataModel.LCLevelList) then
      GetBuff()
    end
  end
end
local module = {}

function module.Refresh(playAni)
  local levelChain = DataModel.selectedLevelChain
  levelChain.Group_Unlock.self:SetActive(true)
  local ca = PlayerData:GetFactoryData(levelChain.data.id, "levelChainFactory")
  DataModel.LCLevelList = {}
  local levelChainList = {}
  local list = ChpaterNewDataController:GenTrackTable(levelChain.Group_Unlock.Group_Track, nil, nil)
  ChpaterNewDataController:ContactNodes(list, {}, levelChainList)
  ChpaterNewDataController.ConcatLCLevel(levelChainList, ca.levelChainList, DataModel.LCLevelList)
  ChapterMapUIController:RefreshLCLevelTrack(levelChain.Group_Unlock.Group_Track.Group_Route1)
  DataController.Center(levelChain.Group_Unlock, false, 0, nil)
  DataModel.chapterId = ca.chapterId
  DataModel.curMapPosition = View.Group_Map.self.transform.position
end

function module.ClosePanel()
  DataModel.curMapPosition = DataModel.chapterPosList[DataModel.chapterId]
  View.Group_Map.self.transform.position = DataModel.curMapPosition
end

function module.CloseLevelChain(callback)
  Net:SendProto("level_chain.close", function()
    ClearPlayerDataLevelChain()
    if callback ~= nil then
      callback()
    end
  end)
end

function module.StartBattleLevelChain()
  local levelData = DataModel.selectedLevel.data
  PlayerData.BattleInfo.battleStageId = levelData.levelId
  local roleIdList = {}
  local header = PlayerData.ServerData.squad[100].header
  for i = 1, table.count(PlayerData.ServerData.squad[100].role_list) do
    local role = {}
    role = PlayerData.ServerData.squad[100].role_list[i]
    if role.id ~= "" then
      local index = role.id == header and 1 or i
      table.insert(roleIdList, index, role)
    end
  end
  local roleDataList = SquadDataController:GetRoleDataList(roleIdList)
  local callback = function(randomSeed)
    local playerLv = PlayerData:GetUserInfo().lv
    ReplayManager:InitBattle(levelData.levelId, randomSeed, playerLv, false, false)
    for k, v in pairs(roleDataList) do
      if next(v) ~= nil and v.isBlocked ~= true then
        ReplayManager:AddRole(tonumber(v.unitId), tonumber(v.unitViewId), tonumber(v.skill1Lv), tonumber(v.skill2Lv), tonumber(v.skill3Lv), tonumber(v.lv), tonumber(v.breakthroughLv), tonumber(v.awakeLv), tonumber(v.resonanceLv), tonumber(v.resonanceStage), tonumber(v.equip1Id), tonumber(v.e1s1Id), tonumber(v.e1s2Id), tonumber(v.e1s3Id), tonumber(v.e1s4Id), tonumber(v.equip2Id), tonumber(v.e2s1Id), tonumber(v.e2s2Id), tonumber(v.e2s3Id), tonumber(v.e2s4Id))
      end
    end
    ReplayManager:RegBattleFinishCallback(BattleFinishCallback)
    _BattleStartCallback()
  end
  Net:SendProto("battle.start_battle", function(json)
    PlayerData.TempCache.GuideNoUpdateLimitData[EnumDefine.GuideNoUpdateLimitDataEnum.LevelId] = levelData.levelId
    if json.levelUid ~= nil then
      PlayerData.BattleInfo.levelUid = json.levelUid
      local CallBack = function()
        callback(json.server_now)
      end
      CommonTips.OpenLoading(CallBack)
    end
    local levelCA = PlayerData:GetFactoryData(levelData.levelId, "LevelFactory")
    if PlayerData.ServerData.record_level == nil then
      PlayerData.ServerData.record_level = {}
    end
    if levelCA ~= nil then
      PlayerData.ServerData.record_level[levelCA.mod] = levelData.levelId
    end
    PlayerData.LevelData = levelCA
  end, levelData.levelId, "", 100, 1, tostring(DataModel.selectedLevel.data.idx - 1))
end

function module.SetBuff(buffIndex)
  if PlayerData.ServerData.level_chain.buffList[tostring(DataModel.selectedLevel.data.idx)] == nil then
    return
  end
  if PlayerData.ServerData.level_chain.buffList[tostring(DataModel.selectedLevel.data.idx)].index == nil then
    Net:SendProto("level_chain.set_buff", function(json)
      PlayerData.ServerData.level_chain.buffList[tostring(DataModel.selectedLevel.data.idx)].index = buffIndex
    end, DataModel.selectedLevel.data.idx - 1, buffIndex - 1)
  else
  end
end

function module.FinishLevelChain()
  local levelChainId = PlayerData.ServerData.level_chain.levelChainId
  local roleList = PlayerData.ServerData.squad[100].role_list
  Net:SendProto("level_chain.finish", function(json)
    ClearPlayerDataLevelChain()
    UIChapterSettlement.Open(json, levelChainId, roleList)
  end)
end

function module:LevelChainMain()
  local yesFunc = function()
    PlayerData.LevelChain.OnLevelChain = true
    local status = {}
    status.chapterId = PlayerData:GetFactoryData(tonumber(PlayerData.ServerData.level_chain.levelChainId), "LevelChainFactory").chapterId
    local params = {
      chapterId = status.chapterId,
      Current = "MainUI"
    }
    PlayerData.Last_Chapter_Parms = params
    PlayerData.ChooseChapterType = 1
    PlayerData.BattleCallBackPage = "UI/Chapter/Chapter"
    UIManager:Open("UI/Chapter/Chapter", Json.encode(status))
  end
  local noFunc = function()
    self.CloseLevelChain()
  end
  CommonTips.OnPrompt(80600246, nil, nil, yesFunc, noFunc)
end

function module.GetSelectedLCLevel()
  return DataModel.selectedLevel
end

function module.GetLevelChainId()
  return DataModel.selectedLevelChain.data.id
end

function module.CanUnlockLevelChain(chapterCA)
  if table.count(chapterCA.levelChainList) == 0 then
    return false
  end
  for k, v in pairs(DataModel.levelList) do
    if v.data.star < 3 then
      return false
    end
  end
  return true
end

function module.SetLevelChainParams(ca)
  if View.Group_Map.Group_LevelChain == nil then
    return
  end
  local listCount = #ca.levelChainList
  for i = 1, table.count(View.Group_Map.Group_LevelChain) - 1 do
    if i > listCount then
      break
    end
    local chain = View.Group_Map.Group_LevelChain["Group_LevelChain" .. i]
    chain.Group_Lock.self:SetActive(true)
    chain.Group_Unlock.self:SetActive(false)
    chain.Group_Lock.Group_LCStart.Btn_Item:SetClickParam(i)
    chain.Group_Lock.Group_LCEnd.Btn_Item:SetClickParam(i)
    chain.data = {}
    chain.data.idx = i
    chain.data.id = ca.levelChainList[i].levelChainId
  end
end

function module.GetLevelChainPass()
  if DataModel.selectedLevelChain == nil then
    return false
  end
  local id = tostring(DataModel.selectedLevelChain.data.id)
  for k, v in pairs(PlayerData.ServerData.cleared_diff_level) do
    if v == id then
      return true
    end
  end
  return false
end

function module.IsLevelChainDrops()
  return DataModel.showLevelChainDrops == true
end

function module.CloseLevelChainDrops()
  DataModel.showLevelChainDrops = nil
end

return module
