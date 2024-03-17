local DataModel = {
  StationId = 0,
  NpcId = 0,
  BgPath = "",
  CurRepLv = 0,
  InvestList = {},
  TradePermissionGoods = {},
  NPCDialogEnum = {
    enterText = "enterText",
    investText = "investText",
    talkText = "talkText",
    investSuccessText = "investSuccessText",
    ItemText = "ItemText",
    investOneText = "investOneText",
    investTwoText = "investTwoText",
    investThreeText = "investThreeText",
    investFourText = "investFourText",
    investFiveText = "investFiveText",
    investSixText = "investSixText"
  },
  DevDegree = 0,
  TotalTZ = 0,
  serverStationData = {},
  AllNoInvest = true
}
local AddTradePermissionGoods = function(stationCA, addTable, isChild)
  for k, v in pairs(stationCA.sellList) do
    local listCA = PlayerData:GetFactoryData(v.id, "ListFactory")
    if DataModel.DevDegree >= listCA.needDevelopNum and listCA.needItemNum > 0 then
      local t = {}
      t.id = v.id
      t.goodsId = listCA.goodsId
      local itemCA = PlayerData:GetFactoryData(t.goodsId, "ItemFactory")
      local goodsCA = PlayerData:GetFactoryData(t.goodsId, "HomeGoodsFactory")
      t.name = itemCA.name
      t.needItemNum = listCA.needItemNum
      t.isSpecial = goodsCA.isShow
      if isChild then
        t.stationName = stationCA.name
      end
      table.insert(addTable, t)
    end
  end
end

function DataModel.InitData()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.InvestList = {}
  DataModel.AllNoInvest = true
  for k, v in pairs(stationCA.investList) do
    local t = {}
    t.name = v.name
    t.repGrade = v.repGrade
    t.limitNum = v.limitNum
    local serverDetail = DataModel.serverStationData.invest[tostring(k - 1)]
    local usedNum = 0
    if serverDetail ~= nil then
      usedNum = serverDetail.cnt
    end
    t.remainNum = t.limitNum - usedNum
    t.developNum = v.developNum
    local isNoInvest = t.limitNum == t.remainNum
    DataModel.AllNoInvest = DataModel.AllNoInvest and isNoInvest
    local listCA = PlayerData:GetFactoryData(v.id, "ListFactory")
    t.costList = listCA.investorCostList
    t.rewardList = listCA.investorRewList
    table.insert(DataModel.InvestList, t)
  end
  DataModel.TradePermissionGoods = {}
  AddTradePermissionGoods(stationCA, DataModel.TradePermissionGoods)
  local attachChildren = PlayerData.TempCache.CacheStationAttachChildren[DataModel.StationId]
  if attachChildren then
    for k, v in ipairs(attachChildren) do
      local ca = PlayerData:GetFactoryData(v, "HomeStationFactory")
      AddTradePermissionGoods(ca, DataModel.TradePermissionGoods, true)
    end
  end
  table.sort(DataModel.TradePermissionGoods, function(a, b)
    if a.needItemNum < b.needItemNum then
      return true
    end
    return false
  end)
end

function DataModel.GetTotalTZ()
  local serverInvest = DataModel.serverStationData.invest
  local num = 0
  if serverInvest ~= nil then
    for k, v in pairs(serverInvest) do
      num = num + v.cost
    end
  end
  return num
end

return DataModel
