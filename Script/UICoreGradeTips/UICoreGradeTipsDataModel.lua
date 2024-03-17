local DataModel = {
  data = {},
  levelInfo = {},
  moveToIdx = 1,
  curLv = 0,
  challengeTxt = 0,
  breakCnt = 0,
  overviewSelectPath = "",
  curSelectIdx = 0,
  GetRewardLv = {},
  defaultOffset = 2
}

function DataModel.Init()
  DataModel.moveToIdx = 1
  local caId = DataModel.data.caId
  local serverInfo = PlayerData.ServerData.engines[tostring(caId)]
  DataModel.GetRewardLv = {}
  if serverInfo.lv_reward then
    for i, getLv in pairs(serverInfo.lv_reward) do
      DataModel.GetRewardLv[getLv] = 0
    end
  end
  DataModel.curLv = serverInfo.lv
  local ca = PlayerData:GetFactoryData(caId)
  DataModel.challengeTxt = GetText(ca.challengeTips)
  DataModel.levelInfo = {}
  local cnt = #ca.coreExpList
  local cacheBattleId = 0
  local cacheUnitId = 0
  local cacheChangeBattleLv = 0
  local breakCnt = 0
  local nextBreakLv = 0
  local idx = 1
  local afterBreakLv = 0
  local preRedName = RedpointTree.NodeNames.Core .. "|" .. caId .. "|"
  for i = 2, cnt do
    local t = {}
    t.lv = i
    t.redName = preRedName .. i
    t.afterBreak = afterBreakLv == i
    if i > cacheChangeBattleLv then
      for k, battleInfo in ipairs(ca.coreLevelList) do
        if i <= battleInfo.grade then
          cacheChangeBattleLv = battleInfo.grade
          cacheBattleId = battleInfo.id
          cacheUnitId = battleInfo.profileId
          break
        end
      end
    end
    t.battleId = cacheBattleId
    if 0 < cacheUnitId then
      local unitCA = PlayerData:GetFactoryData(cacheUnitId)
      t.battleName = unitCA.name
    end
    local info = ca.coreExpList[i]
    t.num = info.num
    t.isBreak = info.isBreak
    if 0 < info.id then
      local listCA = PlayerData:GetFactoryData(info.id)
      t.rewardItems = listCA.EngineRewardList or {}
      if info.isBreak then
        t.breakItems = listCA.breakItemList
        if i < serverInfo.lv then
          breakCnt = breakCnt + 1
        elseif nextBreakLv == 0 then
          nextBreakLv = i
        end
      end
    else
      t.rewardItems = {}
    end
    if i == DataModel.curLv then
      DataModel.moveToIdx = idx
    end
    DataModel.levelInfo[idx + DataModel.defaultOffset] = t
    idx = idx + 1
    if t.isBreak then
      DataModel.levelInfo[idx + DataModel.defaultOffset] = Clone(t)
      DataModel.levelInfo[idx + DataModel.defaultOffset].rewardItems = {}
      DataModel.levelInfo[idx + DataModel.defaultOffset].redName = ""
      DataModel.levelInfo[idx - 1 + DataModel.defaultOffset].isBreak = false
      idx = idx + 1
      afterBreakLv = i + 1
    end
  end
  if nextBreakLv == 0 then
    nextBreakLv = cnt
  end
  DataModel.breakCnt = breakCnt
  DataModel.nextBreakLv = nextBreakLv
end

return DataModel
