local View = require("UIAdvMain/UIAdvMainView")
local DataModel = {
  Data = {},
  digItem = {},
  digCnt = 0,
  resReward = {}
}

function DataModel:Reset()
  DataModel.digItem = {}
  DataModel.digCnt = 0
  DataModel.resReward = {}
end

function DataModel:AdvMGameOver()
  UIManager:Pause(true)
  local advReward = ""
  for i, v in pairs(DataModel.resReward) do
    advReward = advReward .. i .. ":" .. v .. ";"
  end
  Net:SendProto("adventure.end_adv", function(json)
    View.Group_PauseFrame.self:SetActive(false)
    View.Group_SettlementFrame.self:SetActive(true)
    DataModel.Data = PlayerData:SortShowItem(json.reward)
    View.Group_SettlementFrame.Group_ExploreSumUp.ScrollGrid_Items.grid.self:SetDataCount(table.count(DataModel.Data))
    View.Group_SettlementFrame.Group_ExploreSumUp.ScrollGrid_Items.grid.self:RefreshAllElement()
  end, advReward)
end

function DataModel:AdvResourceGet(t, cnt)
  if t == 0 then
    for i = 0, cnt do
      DataModel.digCnt = DataModel.digCnt + 1
      local item = DataModel.digItem[DataModel.digCnt]
      print_r(item)
      for i, v in pairs(item) do
        if DataModel.resReward[v.id] == nil then
          DataModel.resReward[v.id] = v.num
        else
          DataModel.resReward[v.id] = DataModel.resReward[v.id] + v.num
        end
      end
    end
  else
  end
end

return DataModel
