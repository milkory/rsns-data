local DataModel = {
  Top = {
    {id = 11400007, isSpecial = false},
    {
      id = 11400005,
      isSpecial = true,
      key = "bm_rock"
    }
  },
  CardPool = {},
  Index = 1,
  GachaType = 1,
  DataID = "",
  MoneyId = 0,
  CommodityId = 0
}

function DataModel:GetCardPool()
  for i, v in pairs(self.CardPool) do
    if v.detail.timeFunc ~= nil then
      EventManager:RemoveOnSecondEvent(v.detail.timeFunc)
      v.detail.timeFunc = nil
    end
    if v.detail.timeFunc1 ~= nil then
      EventManager:RemoveOnSecondEvent(v.detail.timeFunc1)
      v.detail.timeFunc1 = nil
    end
  end
  self.CardPool = {}
  local factoryData = CacheAndGetFactory("ExtractFactory")
  print_r(PlayerData.ServerData.cards)
  for i, v in pairs(factoryData) do
    if v.mod == "抽角色配置" and v.startTime ~= "" and TimeUtil:IsActive(v.startTime, v.endTime) and (v.questId < 0 or PlayerData.IsQuestComplete(v.questId)) then
      local poolNum = 0
      local poolData = PlayerData.ServerData.cards[tostring(v.id)]
      if poolData ~= nil then
        poolNum = poolData.pool_num or 0
      end
      if v.closeNum == nil then
        error("卡池id: " .. v.id .. " 配置缺少字段'closeNum'")
      end
      if v.closeNum == -1 or poolNum < v.closeNum then
        table.insert(self.CardPool, {
          data = v,
          server = PlayerData.ServerData.cards[tostring(v.id)] or {},
          detail = {}
        })
      end
    end
  end
  table.sort(self.CardPool, function(a, b)
    if a.data.sort ~= b.data.sort then
      return a.data.sort > b.data.sort
    end
    return a.data.id > b.data.id
  end)
end

return DataModel
