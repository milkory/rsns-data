local DataModel = {
  StationId = 0,
  RankListInfo = {},
  TabTypeToIdx = {},
  TimeType = {
    daily = 1,
    weekly = 2,
    all = 3,
    localDaily = 999,
    forever = 4
  },
  TimeTypeToStr = {
    "daily",
    "weekly",
    "",
    "forever",
    [999] = "daily"
  },
  CurDetailInfo = {},
  CurShowIconPng = "",
  CurTabIndex = 0,
  CurTimeType = 0,
  CurRankLvIdx = 0,
  ImgPath = {
    "UI/RankList/first_bg",
    "UI/RankList/second_bg",
    "UI/RankList/third_bg",
    "UI/RankList/other_bg"
  },
  QuickClickTime = 0,
  QuickClickLimit = 10
}

function DataModel.Init()
  local ca = PlayerData:GetFactoryData(DataModel.StationId)
  local rankList
  if ca.mod == "垃圾站" then
    rankList = ca.rubbishRankList
  else
    rankList = ca.tradeRankList
  end
  DataModel.RankListInfo = {}
  DataModel.TabTypeToIdx = {}
  for k, v in pairs(rankList) do
    local t = {}
    local rankCA = PlayerData:GetFactoryData(v.id, "RankFactory")
    t.rankCA = rankCA
    t.rankLv = {}
    local isOneBased = rankCA.sectionType == "onebased"
    local minLv = 0
    local curLv = PlayerData:GetPlayerLevel()
    for k1, v1 in pairs(rankCA.gradeSectionList) do
      local tLv = {}
      if isOneBased then
        tLv.minLv = 1
      else
        tLv.minLv = minLv + 1
      end
      tLv.maxLv = v1.grade
      if t.rankLvSelfIdx == nil and curLv >= tLv.minLv and curLv <= tLv.maxLv then
        t.rankLvSelfIdx = k1
      end
      table.insert(t.rankLv, tLv)
      minLv = v1.grade
    end
    DataModel.TabTypeToIdx[rankCA.rankType] = k
    table.insert(DataModel.RankListInfo, t)
  end
end

return DataModel
