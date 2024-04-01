local View = require("UIMoonthCard/UIMoonthCardView")
local DataModel = {DropAwardList = nil}
local ShowReward = function()
  Net:SendProto("main.monthly_card", function(json)
    DataModel.DropAwardList = PlayerData:SortShowItem(json.reward)
    if PlayerData.ServerData.monthly_card and PlayerData.ServerData.monthly_card["11400018"] then
      local t = PlayerData.ServerData.monthly_card["11400018"]
      local diff = 0
      if t.reward_ts then
        if t.reward_ts <= t.deadline then
          diff = t.deadline - t.reward_ts
        end
      else
        if t.reward_date == nil or t.reward_date == "" then
          t.reward_date = os.date("%Y-%m-%d %H:%M:%S", TimeUtil:GetFutureTime(0, 6))
        end
        local lastTime = os.time(TimeUtil:GetTimeTable(t.reward_date))
        if lastTime <= t.deadline then
          diff = t.deadline - lastTime
        end
      end
      if 0 < diff then
        local time = TimeUtil:SecondToTable(diff)
        View.Group_Reward.Group_Time.Txt_Time:SetText(string.format(GetText(80601102), time.day - 1))
        View.Group_Reward.self:SetActive(true)
        View.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(table.count(DataModel.DropAwardList))
        View.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
        View.self:PlayAnim("MonthCardDotAnim")
      end
    end
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
