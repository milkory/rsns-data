local DataModel = {
  StationId = 0,
  PosX = 0,
  PosY = 0,
  CurLv = 1,
  MoveToPos = 1,
  RewardList = {},
  LinePath = {
    "Ui/HomeReputation/New/line_wei",
    "Ui/HomeReputation/New/line_already",
    "Ui/HomeReputation/New/line_alreadyget"
  }
}

function DataModel.InitData()
  DataModel.RewardList = {}
  local stationId = DataModel.StationId
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  DataModel.CurLv = serverStation.rep_lv or 0
  local isGet = {}
  if serverStation.rep_reward ~= nil then
    for k, v in pairs(serverStation.rep_reward) do
      isGet[v] = 1
    end
  end
  local HomeCommon = require("Common/HomeCommon")
  local rewardList = HomeCommon.GetRepRewardList(stationId)
  local rep = 500
  local minLv = 0
  for i = 2, #rewardList do
    local v = rewardList[i]
    local lv = i - 1
    local t = {}
    local listCA = PlayerData:GetFactoryData(v.id, "ListFactory")
    t.rewards = listCA.repRewardList
    t.honorPng = v.honorPng
    t.desc = v.desc
    t.needRep = math.floor(rep + 0.5)
    rep = rep + v.repNum
    t.state = 0
    if lv <= DataModel.CurLv then
      t.state = 1
    end
    if isGet[lv] then
      t.state = 2
    elseif minLv == 0 then
      minLv = lv
    end
    table.insert(DataModel.RewardList, t)
  end
  DataModel.MoveToPos = minLv < DataModel.CurLv and minLv or DataModel.CurLv
end

return DataModel
