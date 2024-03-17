local View = require("UIMoonthCard/UIMoonthCardView")
local DataModel = {DropAwardList = nil}
local ShowReward = function()
  Net:SendProto("main.monthly_card", function(json)
    DataModel.DropAwardList = PlayerData:SortShowItem(json.reward)
    PlayerData.ServerData.monthly_card["11400018"].reward_date = os.date("%Y-%m-%d %H:%M:%S", TimeUtil:GetFutureTime(0, 5))
    local diff = PlayerData.ServerData.monthly_card["11400018"].deadline - TimeUtil:GetFutureTime(0, 5)
    local time = TimeUtil:SecondToTable(diff)
    View.Group_Reward.Group_Time.Txt_Time:SetText(string.format(GetText(80601102), time.day))
    View.Group_Reward.self:SetActive(true)
    View.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(table.count(DataModel.DropAwardList))
    View.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
    View.self:PlayAnim("MonthCardDotAnim")
  end)
end

function DataModel.ClickBG()
  if View.Group_Reward.self.IsActive == false then
    ShowReward()
    return
  end
  UIManager:CloseTip("UI/Common/MoonthCard/MoonthCard")
end

return DataModel
